# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "phlex"

class Layout < Phlex::View
  def initialize(view, args)
    @view = view
    @args = args
  end

  def template
    html do
      head do
        title { "Palaver" }
        link rel: "stylesheet", href: "https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css"
      end

      body do
        nav(class: "navbar", role: "navigation") do
          div(class: "navbar-brand") do
            div(class: "navbar-item") do
              a(href: "/") { "Home" }
            end
          end
        end

        section(class: "section") do
          render @view.new(**@args)
        end
      end
    end
  end
end

module Palaver
  class Action < Hanami::Action
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
  end
end
