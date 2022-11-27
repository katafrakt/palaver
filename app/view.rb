require "ui/typography"
require "ui/form"

class Palaver::View < Phlex::HTML
  attr_reader :context, :args

  class Context
    def initialize(response)
      @response = response
    end

    def flash = @response.flash
    def csrf_token = @response.session[:_csrf_token]

    def current_user
      return @_current_user if instance_variable_defined?(:@_current_user)

      session_id = @response.session[:usi]
      @_current_user = if session_id
        Account::Container["repositories.account"].by_session_id(session_id)
      end
      @_current_user
    end
  end

  def initialize(context, args = {})
    @context = context
    @args = args
    define_args_vars
  end

  def flash = context.flash
  def csrf_token = context.csrf_token
  def current_user = context.current_user

  private

  def define_args_vars
    # TODO: forbid some names
    @args.each do |name, value|
      instance_variable_set("@#{name}".to_sym, value)
    end
  end
end
