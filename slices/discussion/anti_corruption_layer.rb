module Discussion::AntiCorruptionLayer
  def self.transform_current_user(current_user)
    raise RuntimeError unless current_user.is_a?(Account::Entities::CurrentUser) ||
                              current_user.is_a?(Account::Entities::AnonymousUser)

    if current_user.signed_in?
      attrs = {
        id: current_user.id,
        email: current_user.email
      }

      profile = Discussion::Container["repositories.profile"].from_current_user(current_user)
      if profile
        attrs.merge!(
          {
            profile_id: profile.id,
            username: profile.nickname,
            message_count: profile.message_count,
            avatar_data: profile.avatar_data

          }
        )
      end

      Discussion::Entities::CurrentUser.new(**attrs)
    else
      Discussion::Entities::CurrentUser.new
    end
  end
end
