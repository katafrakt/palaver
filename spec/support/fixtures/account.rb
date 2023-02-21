module Fixtures
  module Account
    extend self

    def user
      _, user = ::Account::Container["commands.register_user"].call("#{SecureRandom.hex(16)}@test.com", "123123123")
      user
    end
  end
end
