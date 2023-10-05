require "ui"

class Palaver::View < Phlex::HTML
  attr_reader :context, :args

  class Context
    def initialize(response)
      @response = response
    end

    def flash = @response.flash

    def csrf_token = @response.session[:_csrf_token]

    def current_user = @response[:current_user]

    def asset_url(asset) = Hanami.app["assets"][asset].url
  end

  def initialize(context, args = {})
    @context = context
    @args = args
    define_args_vars
  end

  def flash = context.flash

  def csrf_token = context.csrf_token

  def current_user = context.current_user

  # Standard check must be disabled, because we still support Ruby 3.1
  def asset_url(*args) = context.asset_url(*args) # standard:disable Style/ArgumentsForwarding

  private

  def define_args_vars
    # TODO: forbid some names
    @args.each do |name, value|
      instance_variable_set("@#{name}".to_sym, value)
    end
  end
end
