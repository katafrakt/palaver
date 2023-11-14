module Fixtures
  module Discussion
    extend self

    def category
      ::Discussion::Container["repositories.category"]
        .create(name: "test category")
    end

    def thread(category_id:, author:)
      event = ::Discussion::Events::ThreadCreated.new(
        title: "test thread",
        content: "this is the thread",
        category_id:,
        creator: author
      )

      ::Discussion::Container["repositories.thread"].handle_event(event)
    end

    def profile
      # there's a cross-slice dependency here, but I guess it is okay in test code
      # Discussion slice does not have the rights to write profiles, but they are
      # needed to read.
      repo = ::Account::Container["repositories.profile"]
      record = repo.create(nickname: "test", account_id: 1)
      ::Discussion::Entities::Profile.new(record.to_h.merge(message_count: 1))
    end
  end
end
