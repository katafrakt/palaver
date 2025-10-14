module Factories
  module Account
    extend self

    def user(password: SecureRandom.hex(10))
      ::Account::Container["operations.register"]
        .call(email: "#{SecureRandom.hex(16)}@test.com", password:)
        .value!
    end

    def profile(account_id = nil)
      account_id ||= user.id
      repo = ::Account::Container["repositories.profile"]
      repo.create(nickname: "test", account_id:)
    end

    def current_user_entity(args)
      ::Account::Entities::CurrentUser.new(args)
    end
  end
end
