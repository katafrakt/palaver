module HanamiExtensions
  module ResponseExtension
    def render(view, **args)
      unless args.key?(:layout)
        context = Palaver::View::Context.new(self)
        layout = Ui::Layout.new(view, context, args)
        self.body = layout.call
      end
    end
  end
end

Hanami::Action::Response.prepend(HanamiExtensions::ResponseExtension)
