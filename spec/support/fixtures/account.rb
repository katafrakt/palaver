module Fixtures
  module Account
    extend self

    def user(password: SecureRandom.hex(10))
      ::Account::Container["commands.register_user"]
        .call("#{SecureRandom.hex(16)}@test.com", password)
        .value!
    end

    def profile(user_id = nil)
      ::Discussion::Container["commands.create_profile"]
        .call(nickname: "Tester", account_id: user_id)
        .value!
    end

    def current_user_entity(args)
      ::Account::Entities::CurrentUser.new(args)
    end
  end
end
