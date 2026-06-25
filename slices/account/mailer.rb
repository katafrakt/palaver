require "hanami-mailer"

module Account
  class Mailer < Hanami::Mailer
    NoTemplate = Class.new(StandardError)
    extend Dry::Core::ClassAttributes

    Types = Palaver::Types

    defines :html_renderer, :template_input_def

    from "palaver@localhost"

    def self.html_template(&block)
      cls = Class.new(Phlex::HTML)

      cls.define_method :initialize do |input|
        @input = input
      end

      cls.define_method :view_template do
        instance_exec(@input, &block)
      end

      # assign our anonyomus class to the class attribute
      html_renderer cls
    end

    def self.template_input(&block)
      template_input_def Class.new(Dry::Struct, &block)
    end

    private

    def render_view(_format, input)
      renderer = self.class.html_renderer
      raise NoTemplate unless self.class.html_renderer

      input = self.class.template_input_def ? self.class.template_input_def.new(input) : input
      renderer.new(input).call
    end
  end
end
