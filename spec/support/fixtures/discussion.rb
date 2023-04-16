module Fixtures
  module Discussion
    extend self

    def category
      ::Discussion::Container["repositories.category"]
        .create(name: "test category")
    end

    def thread(category_id:, author:)
      ::Discussion::Container["commands.create_thread"]
        .call(title: "test thread", content: "this is the thread",
          category_id:, author:)
        .value!
    end

    def profile
      ::Discussion::Container["commands.create_profile"].call(
        nickname: "test", account_id: 1
      ).value!
    end
  end
end
