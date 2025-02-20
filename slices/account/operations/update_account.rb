module Account
  module Operations
    class UpdateAccount < Account::Operation
      include Account::Deps[repo: "repositories.account", profile_repo: "repositories.profile", hasher: "utils.hasher"]

      def call(user, attrs)
        profile = step ensure_profile_exists(user)
        step update_profile_attributes(profile, attrs)
        step change_password(user, attrs)
        step set_avatar(profile, attrs[:avatar])
        step reload_user(user.id)
      end

      private

      # Right after the user registered, they might only have an Account
      # record present, with Profile record to be created later. This is
      # the moment when we need to check it.
      def ensure_profile_exists(user)
        profile = profile_repo.by_account_id(user.id)

        if profile.nil?
          Success(profile_repo.create(account_id: user.id))
        else
          Success(profile)
        end
      end

      # Update the "regular" attributes
      def update_profile_attributes(profile, attrs)
        allowed_keys = [:nickname]
        filtered_attrs = attrs.slice(*allowed_keys)
        profile_repo.update(profile.id, filtered_attrs) unless filtered_attrs.empty?
        Success()
      end

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

      def set_avatar(profile, avatar)
        return Success() if Hanami::Utils::Blank.blank?(avatar)

        attacher = Account::Entities::Settings.avatar_attacher
        attacher.assign(avatar)
        attacher.finalize

        params = {avatar_data: attacher.column_data}
        profile = profile_repo.update(profile.id, params)
        Success(profile)
      end

      def reload_user(id)
        user = repo.settings_by_user_id(id)
        Success(user)
      end
    end
  end
end
