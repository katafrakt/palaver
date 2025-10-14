module Account
  module Operations
    class UpdateProfile < Account::Operation
      include Deps[repo: "repositories.profile"]

      def call(user, attrs)
        profile = step ensure_profile_exists(user)
        step update_profile_attributes(profile, attrs)
        step set_avatar(profile, attrs[:avatar])
      end

      private

      # Right after the user registered, they might only have an Account
      # record present, with Profile record to be created later. This is
      # the moment when we need to check it.
      def ensure_profile_exists(user)
        profile = repo.by_account_id(user.id)

        if profile.nil?
          Success(repo.create(account_id: user.id))
        else
          Success(profile)
        end
      end

      # Update the "regular" attributes
      def update_profile_attributes(profile, attrs)
        allowed_keys = [:nickname]
        filtered_attrs = attrs.slice(*allowed_keys)
        repo.update(profile.id, filtered_attrs) unless filtered_attrs.empty?
        Success()
      end

      def set_avatar(profile, avatar)
        return Success() if Hanami::Utils::Blank.blank?(avatar)

        attacher = Account::Entities::Settings.avatar_attacher
        attacher.assign(avatar)
        attacher.finalize

        params = {avatar_data: attacher.column_data}
        profile = repo.update(profile.id, params)
        Success(profile)
      end
    end
  end
end
