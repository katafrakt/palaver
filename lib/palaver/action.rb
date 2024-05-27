# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "hanami/action/session"
require "phlex"
require "dry/monads"
require "ui/layout"
require "hanami_extensions"

module Palaver
  class Action < Hanami::Action
    include Hanami::Action::Session
    include Dry::Monads[:result]
    include Account::Deps[account_repo: "repositories.account"]

    before :fetch_current_user_id

    # Hacking around Hanami deficiencies which only allow using schema validation
    # without rules validation
    def self.contract(&block)
      klass = Class.new(Hanami::Action::Params)
      contract = Dry::Validation::Contract.build { instance_eval(&block) }
      klass.instance_variable_set(:@_validator, contract)
      @params_class = klass
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

    def render_on_invalid_params(res, template)
      req = res.request
      if !req.params.valid?
        body = res.render(template, values: req.params.to_h, errors: req.params.errors)
        halt(422, body)
      end
    end

    # NOTE: need to overwrite this internal method so the  csrf checker uses raw params,
    # not the params from req.params - which requires to manually allow _csrf_token param
    # if I'm using .contract method defined above
    #
    # Overwrites missing_csrf_token? for the same reason
    def invalid_csrf_token?(req, res)
      return false unless verify_csrf_token?(req, res)

      missing_csrf_token?(req, res) ||
        !::Rack::Utils.secure_compare(req.session[CSRF_TOKEN], req.params.raw[CSRF_TOKEN])
    end

    def missing_csrf_token?(req, *)
      Hanami::Utils::Blank.blank?(req.params.raw[CSRF_TOKEN])
    end

    public

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
  end
end
