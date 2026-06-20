require "hanami-mailer"

module Account
  class Mailer < Hanami::Mailer
    NoTemplate = Class.new(StandardError)
    extend Dry::Core::ClassAttributes

    Types = Palaver::Types

    defines :html_renderer

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

    private

    def render_view(_format, input)
      renderer = self.class.html_renderer
      raise NoTemplate unless self.class.html_renderer
      renderer.new(input).call
    end
  end
end
