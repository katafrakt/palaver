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
        render @view.new(**@args)
      end
    end
  end
end

module Palaver
  class Action < Hanami::Action
    def render(view, **args)
      Layout.new(view, args).call
    end
  end
end
