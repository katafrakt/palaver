# auto_register: false
# frozen_string_literal: true

require "hanami/action"
require "hanami/action/session"
require "phlex"

class Layout < Phlex::HTML
  attr_reader :flash

  def initialize(view, args)
    @view = view
    @flash = args.delete(:flash)
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

        if flash && flash[:error]
          article(class: "message is-danger") do
            div(class: "message-body") { flash[:error] }
          end
        end

        section(class: "section") do
          render @view.new(**@args)
        end
      end
    end
  end
end

module HanamiPhlexView
  module ResponseExtension
    def render(view, **args)
      layout_args = {flash: self.flash}.merge(args)
      layout = Layout.new(view, layout_args)
      self.body = layout.call
    end
  end
end

Hanami::Action::Response.prepend(HanamiPhlexView::ResponseExtension)

module HanamiPhlexView
  def self.included(base)
    base.extend ClassMethods
    base.prepend PrependedMethods
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

  module PrependedMethods
    def finish(req, res, halted)
      super(req, res, halted)
    end
  end
end

module Palaver
  class Action < Hanami::Action
    include Hanami::Action::Session
    include HanamiPhlexView

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
