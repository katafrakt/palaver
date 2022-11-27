# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "hanami/action/session"
require "phlex"
require "dry/monads"

class Layout < Palaver::View
  def initialize(view, context, args)
    super(context, args)
    @view = view
  end

  def template
    html do
      head do
        title { "Palaver" }
        link rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css"
      end

      body do
        nav(class: "navbar", role: "navigation") do
          container do
            div(class: "navbar-brand") do
              div(class: "navbar-item") do
                a(href: "/") { "Home" }
              end
            end

            div(class: "navbar-menu") do
              div(class: "navbar-end") do
                if current_user
                  div(class: "navbar-item has-dropdown is-hoverable") do
                    a(class: "navbar-link") { "User" }
                    div(class: "navbar-dropdown") do
                      a(class: "navbar-item", href: "/account/profile") { "My Profile" }
                      a(class: "navbar-item", href: "/account/sign_out") { "Sign out" }
                    end
                  end
                else
                  a(href: "/account/sign_in", class: "navbar-item") { "Sign in" }
                end
              end
            end
          end
        end

        container do
          if flash && flash[:error]
            article(class: "message is-danger") do
              div(class: "message-body") { flash[:error] }
            end
          end

          if flash && flash[:success]
            article(class: "message is-success") do
              div(class: "message-body") { flash[:success] }
            end
          end

          section(class: "section") do
            render @view.new(context, **args)
          end
        end
      end
    end
  end

  def container(&)
    div(class: "container", &)
  end
end

module HanamiPhlexView
  module ResponseExtension
    def render(view, **args)
      context = Palaver::View::Context.new(self)
      layout = Layout.new(view, context, args)
      self.body = layout.call
    end
  end
end

Hanami::Action::Response.prepend(HanamiPhlexView::ResponseExtension)

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

    def current_user(req)
      return @_current_user if instance_variable_defined?(:@_current_user)

      session_id = req.session[:usi]
      @_current_user = if session_id
        Account::Container["repositories.account"].by_session_id(session_id)
      end
    end

    # NOTE: need to overwrite this internal methot so the  csrf checker uses raw params,
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
