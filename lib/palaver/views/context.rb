# frozen_string_literal: true

class Palaver::Views::Context < Phlex::Hanami::Context
  attr_reader :current_user

  def initialize(current_user: nil, assets: nil, **)
    # Slices without their own assets dir have no "assets" component, so fall
    # back to the app's assets.
    assets ||= Hanami.app["assets"] if Hanami.app.key?("assets")
    super(assets:, **)
    @current_user = current_user
  end
end
