# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "hanami/action/session"
require "phlex"
require "dry/monads"
require "ui/layout"
require "hanami_extensions"

module HanamiPhlexView
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def view(view_class = Dry::Core::Undefined)
      if view_class == Dry::Core::Undefined
        @view_class
      else
        @view_class = view_class
      end
    end
  end
end

module Palaver
  class Action < Hanami::Action
    include Hanami::Action::Session
    include HanamiPhlexView
    include Dry::Monads[:result]

    before :fetch_current_user

    def render(view, **args)
      Layout.new(view, args).call
    end

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

    def fetch_current_user(req, res)
      session_id = req.session[:usi]
      user = Account::Container["repositories.account"].by_session_id(session_id)
      res[:current_user] = user
    end

    def render_on_invalid_params(res, template)
      req = res.request
      if !req.params.valid?
        res.status = 422
        res.body = render(template, values: req.params.to_h, errors: req.params.errors)
        halt
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
  end
end
