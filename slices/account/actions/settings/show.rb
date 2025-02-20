# frozen_string_literal: true

class Account::Actions::Settings::Show < Account::Action
  include Account::Deps[repo: "repositories.account"]

  require_signed_in_user!

  def handle(req, res)
    settings = repo.settings_by_user_id(res[:current_user].id)
    res.render(Account::Views::Settings::Show, settings:, errors: {}, values: {})
  end
end
