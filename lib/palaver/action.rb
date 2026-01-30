# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "hanami/action/session"
require "phlex"
require "dry/monads"
require "ui/layout"
require "hanami_extensions"
require "palaver/locale_detector"

module Palaver
  class Action < Hanami::Action
    include Hanami::Action::Session
    include Dry::Monads[:result]
    include Account::Deps[account_repo: "repositories.account"]

    before :fetch_current_user_id
    before :set_locale

    # Redirects to root page if the user is not signed in
    def self.require_signed_in_user!
      before do |_, res|
        unless res[:_current_user_id]
          res.flash[:error] = "You need to be signed in to access this page"
          res.redirect_to "/"
        end
      end
    end

    def self.require_signed_out_user!
      before do |_, res|
        if res[:_current_user_id]
          res.flash[:error] = "You are already signed in"
          res.redirect_to "/"
        end
      end
    end

    private

    def validate_params(req)
      req.params.valid? ? Success() : Failure(:invalid_params)
    end

    def fetch_current_user_id(req, res)
      session_id = req.session[:usi]
      user = account_repo.by_session_id(session_id)
      res[:_current_user_id] = user.signed_in? ? user.id : nil
    end

    def set_locale(req, res)
      res[:locale] = LocaleDetector.new(req, res).detect
    end

    def render_on_invalid_params(res, template)
      req = res.request
      return if req.params.valid?

      body = res.render(template, values: req.params.to_h, errors: req.params.errors)
      halt(422, body)
    end
  end
end
