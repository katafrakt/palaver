module Account
  module Operations
    class UpdateAccount < Account::Operation
      include Account::Deps[repo: "repositories.account", hasher: "utils.hasher"]

      def call(user, attrs)
        step change_password(user, attrs)
        step reload_user(user.id)
      end

      private

      # Changes the password of the user
      #
      # Only happens if all the conditions are met:
      #  * New password is provided
      #  * Current passwor dis provided and correct
      def change_password(user, attrs)
        return Success() if Hanami::Utils::Blank.blank?(attrs[:new_password])
        return Failure(:current_password_invalid) unless Argon2::Password.verify_password(attrs[:current_password], user.password_hash)

        new_hash = hasher.create(attrs[:new_password])
        user = repo.update(user.id, password_hash: new_hash)
        Success(user)
      end

      def reload_user(id)
        user = repo.settings_by_user_id(id)
        Success(user)
      end
    end
  end
end
