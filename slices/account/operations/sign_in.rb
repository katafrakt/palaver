# frozen_string_literal: true

require "argon2"

module Account
  module Operations
    class SignIn < Account::Operation
      include Account::Deps[repo: "repositories.account"]

      def call(email:, password:)
        account = step fetch_account(email)
        step verify_password(account, password)
      end

      private

      def fetch_account(email)
        account = repo.get_by_email(email)

        if account.nil?
          Failure(:not_found)
        elsif account.confirmed_at.nil?
          Failure(:not_confirmed)
        else
          Success(account)
        end
      end

      def verify_password(account, password)
        if Argon2::Password.verify_password(password, account.password_hash)
          Success(account)
        else
          Failure(:incorrect_password)
        end
      end
    end
  end
end
