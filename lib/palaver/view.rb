# frozen_string_literal: true

require "phlex/hanami"
require "ui"

class Palaver::View < Phlex::Hanami::View
  layout Palaver::Views::Layout

  private

  def current_user = hanami_context.current_user
end
