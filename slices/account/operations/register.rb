module Account
  module Operations
    class Register < Account::Operation
      include Deps[
        "mailer",
        registration_email: "emails.post_register",
        repo: "repositories.account",
        hasher: "utils.hasher"
              ]

      def call(email:, password:)
        confirmation_token = step generate_confirmation_token
        account = step create_account(email:, password:, confirmation_token:)
        step send_email(account)
        account
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

      def send_email(account)
        email = registration_email.build(account:)
        mailer.deliver(email)
        Success()
      end
    end
  end
end
