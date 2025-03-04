# frozen_string_literal: true

module Account
  module Operations
    class ConfirmUser < Account::Operation
      include Account::Deps[repo: "repositories.account"]
      def call(id:, token:)
        account = step fetch_account(id, token)
        step confirm_account(account)
      end

      private

      def fetch_account(id, token)
        account = repo.by_id_and_token(id, token)
        return Failure(:user_not_found) unless account
        return Failure(:already_confirmed) if account.confirmed_at
        Success(account)
      end

      def confirm_account(account)
        repo.confirm_user(account)
        Success(account)
      end
    end
  end
end
