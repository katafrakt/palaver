# frozen_string_literal: true

module Discussion
  module Relations
    class Threads < Palaver::DB::Relation
      schema(:threads, infer: true) do
        associations do
          belongs_to :categories, as: :category
          has_many :messages
          has_one :categories, as: :latest_thread
          belongs_to :messages, as: :last_message
        end
      end

      use :pagination

      def with_message_counts
        left_join(:messages, {thread_id: :id}, table_alias: :regular_messages)
          .select_append { [integer.count(Sequel[:regular_messages][:id]).as(:message_count)] }
      end
    end
  end
end
