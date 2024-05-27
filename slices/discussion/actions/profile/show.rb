# frozen_string_literal: true

class Discussion::Actions::Profile::Show < Discussion::Action
  include Discussion::Deps[
            repo: "repositories.profile"
          ]

  require_signed_in_user!

  def handle(req, res)
    profile = res[:current_user]

    if profile.profile_set_up?
      res.render(Discussion::Views::Profile::Show, profile:)
    else
      res.redirect "/account/settings"
    end
  end
end
