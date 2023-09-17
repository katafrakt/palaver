# frozen_string_literal: true

class Account::Actions::Settings::Show < Account::Action
  include Account::Deps[fetch_settings: "queries.settings"]

  require_signed_in_user!

  def handle(req, res)
    settings = fetch_settings.call(res[:current_user].id)
    res.render(Account::Templates::Settings::Show, settings:, errors: {}, values: {})
  end
end
