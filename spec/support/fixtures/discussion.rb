require "securerandom"

module Fixtures
  module Discussion
    extend self

    def category
      ::Discussion::Container["repositories.category"]
        .create(name: "test category")
    end

    def thread(category:, author:, title: "test thread", content: "this is the thread", locked: false)
      ::Discussion::Container["repositories.thread"].create(
        title:,
        content:,
        category:,
        creator: author
      )
    end

    def message(thread:, author:, content:)
      ::Discussion::Container["repositories.thread"].add_reply(thread:, author:, content:)
    end

    def profile(account_id: nil)
      account_id ||= ::Account::Container["repositories.account"].create(email: "#{SecureRandom.hex(8)}@test.com").id
      # there's a cross-slice dependency here, but I guess it is okay in test code
      # Discussion slice does not have the rights to write profiles, but they are
      # needed to read.
      repo = ::Account::Container["repositories.profile"]
      record = repo.create(nickname: "test", account_id:)
      ::Discussion::Entities::Profile.new(record.to_h.merge(message_count: 1))
    end
  end
end
