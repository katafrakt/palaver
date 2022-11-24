class Palaver::View < Phlex::HTML
  attr_reader :context, :args

  class Context
    def initialize(response)
      @response = response
    end

    def flash = @response.flash
    def csrf_token = @response.session[:_csrf_token]
  end

  def initialize(context, args = {})
    @context = context
    @args = args
    define_args_vars
  end

  def flash = context.flash
  def csrf_token = context.csrf_token

  private

  def define_args_vars
    # TODO: forbid some names
    @args.each do |name, value|
      instance_variable_set("@#{name}".to_sym, value)
    end
  end
end
