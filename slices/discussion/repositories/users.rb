module Discussion
  module Repositories
    class Users < Palaver::Repository[:profiles]
      def get(id)
        profile = profiles.combine(:account).by_pk(id).one!
        Discussion::Entities::User.new(
          nickname: profile.nickname,
          email: profile.account.email,
          message_count: profile.message_count
        )
      end
    end
  end
end
