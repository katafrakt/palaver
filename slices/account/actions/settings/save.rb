# frozen_string_literal: true

require 'argon2'
require "dry/monads"
require "dry/monads/do"

class Account::Actions::Settings::Save < Account::Action
  include Account::Deps[fetch_settings: "queries.settings", change_password: "commands.change_password"]

  require_signed_in_user!

  contract do
    params do
      optional(:current_password).maybe(:string)
      optional(:new_password).maybe(:string, min_size?: 8)
      optional(:new_password_confirmation).maybe(:string, min_size?: 8)
      optional(:avatar)
    end

    rule(:new_password_confirmation, :new_password) do
      key.failure("passwords do not match") if values[:new_password] != values[:new_password_confirmation]
    end
  end

  def handle(req, res)
    current_user = res[:current_user]

    result = Dry::Monads::Do.() do
      Dry::Monads::Do.bind validate_params(req)
      Dry::Monads::Do.bind verify_current_password(current_user, req)
      Dry::Monads::Do.bind change_password.call(current_user.id, req.params[:new_password]) if req.params[:new_password]
      Success()
    end

    case result
    when Failure(:invalid_params)
      render_show(req, res)
    when Failure(:current_password_invalid)
      req.params.errors[:current_password] = ["incorrect password"]
      render_show(req, res)
    when Success()
      res.flash[:success] = "Settings saved."
      res.redirect_to "/account/settings"
    end
  end

  private

  def render_show(req, res)
    current_user = res[:current_user]
    settings = fetch_settings.call(current_user.id)
    res.render(Account::Templates::Settings::Show, settings:, errors: req.params.errors, values: req.params.to_h)
  end

  def verify_current_password(account, req)
    if Argon2::Password.verify_password(req.params[:current_password], account.password_hash)
      Success()
    else
      Failure(:current_password_invalid)
    end
  end
end
