# frozen_string_literal: true

class Discussion::Actions::Home::Index < Palaver::Action
  def handle(req, res)
    res.body = render(Discussion::Templates::Home::Index, target: "world")
  end
end