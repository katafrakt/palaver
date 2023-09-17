# frozen_string_literal: true

module Account
  module Queries
    class Settings
      include Account::Deps[repo: "repositories.account"]

      def call(user_id)
        settings = repo.settings_for_user(user_id)
        Account::Entities::Settings.from_rom(settings)
      end
    end
  end
end
