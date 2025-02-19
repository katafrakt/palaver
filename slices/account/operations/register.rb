module Account
  module Operations
    class Register < Account::Operation
      include Account::Deps[repo: "repositories.account", hasher: "utils.hasher"]

      def call(email:, password:)
        confirmation_token = step generate_confirmation_token
        step create_account(email:, password:, confirmation_token:)
      end

      private

      def generate_confirmation_token
        Success(SecureRandom.uuid)
      end

      def create_account(email:, password:, confirmation_token:)
        password_hash = hasher.create(password)
        account = repo.create(
          email: email,
          password_hash: password_hash,
          confirmation_token: confirmation_token,
          registered_at: Time.now.utc
        )
        Success(account)
      rescue ROM::SQL::UniqueConstraintError
        Failure(:email_not_unique)
      end
    end
  end
end
