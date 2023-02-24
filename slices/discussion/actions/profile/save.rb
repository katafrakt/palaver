# frozen_string_literal: true

class Discussion::Actions::Profile::Save < Discussion::Action
  include Discussion::Deps[
    repo: "repositories.profile",
    create: "commands.create_profile",
    update: "commands.update_profile"
  ]

  require_signed_in_user!

  params do
    optional(:username).filled(:str?)
    optional(:avatar)
  end

  def handle(req, res)
    profile = repo.from_current_user(res[:current_user])
    result =
      if profile
        update.call(avatar: req.params[:avatar], account_id: res[:current_user].id)
      else
        create.call(nickname: req.params[:username], avatar: req.params[:avatar],
                    account_id: res[:current_user].id)
      end

    if result.success?
      res.flash[:success] = "Your profile has been updated"
      res.redirect "/"
    end
  end
end
