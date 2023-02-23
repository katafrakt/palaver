module Fixtures
  module Account
    extend self

    def user
      ::Account::Container["commands.register_user"]
        .call("#{SecureRandom.hex(16)}@test.com", "123123123")
        .value!
    end

    def current_user_entity(args)
      ::Account::Entities::CurrentUser.new(args)
    end
  end
end
