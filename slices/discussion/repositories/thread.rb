# frozen_string_literal: true

module Discussion
  module Repositories
    class Thread < Palaver::DB::Repo[:threads]
      commands :create

      def by_category(category_id)
        threads.where(category_id:)
          .combine(:last_message)
          .order([Sequel.case({pinned: 0}, 1)])
          .to_a
      end

      def message_counts(thread_ids)
        messages
          .where(thread_id: thread_ids)
          .group(:thread_id)
          .select { [thread_id, integer.count(id).as(:count)] }
          .order(:thread_id)
          .to_a
      end

      # temp
      def create_profile(name)
        profiles.command(:create).call(nickname: name, message_count: 0)
      end

      def get(id)
        threads.by_pk(id).one!.then { |struct| to_entity(struct) }
      end

      def paged_messages(thread_id, page = 1)
        messages
          .where(thread_id:)
          .combine(:author)
          .order(:posted_at)
          .per_page(15)
          .page(page)
          .to_a
      end

      def sync_message_count(author)
        count = messages.where(author_id: author.id).count
        profiles.by_pk(author.id).changeset(:update, message_count: count).commit
      end

      def handle(event)
        case event
        when Discussion::Events::ReplyAddedToThread
          message = messages
            .changeset(
              :create,
              text: event.content,
              posted_at: DateTime.now,
              author_id: event.author.id,
              thread_id: event.thread_id
            ).commit

          threads.by_pk(message.thread_id).changeset(
            :update,
            last_message_id: message.id
          ).commit

          sync_message_count(event.author)

          Discussion::Entities::Message.from_rom(
            messages.by_pk(message.id).combine(:author).one
          )
        when Discussion::Events::ThreadCreated
          transaction do
            thread = threads.changeset(
              :create,
              title: event.title,
              category_id: event.category_id
            ).commit

            message = messages.changeset(
              :create,
              text: event.content,
              posted_at: DateTime.now,
              author_id: event.creator.id,
              thread_id: thread.id
            ).commit

            sync_message_count(event.creator)
            thread = threads.by_pk(thread.id).changeset(
              :update,
              first_message_id: message.id,
              last_message_id: message.id
            ).commit
            Discussion::Entities::Thread.from_rom(thread)
          end
        else
          raise NotImplementedError
        end
      end

      private

      def to_entity(struct)
        Discussion::Entities::Thread.new(
          id: struct.id,
          title: struct.title,
          pinned: struct.pinned,
          locked: struct.locked
        )
      end
    end
  end
end
