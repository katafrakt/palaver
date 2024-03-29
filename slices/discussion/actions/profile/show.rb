# frozen_string_literal: true

class Discussion::Actions::Profile::Show < Discussion::Action
  include Discussion::Deps[
            repo: "repositories.profile"
          ]

  require_signed_in_user!

  def handle(req, res)
    profile = repo.from_current_user(res[:current_user])

    if profile
      res.render(Discussion::Views::Profile::Show, profile:)
    else
      res.redirect "/account/settings"
    end
  end
end
