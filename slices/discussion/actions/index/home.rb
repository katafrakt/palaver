# frozen_string_literal: true

class Discussion::Actions::Index::Home < Palaver::Action
  def handle(req, res)
    res.body = render(Discussion::Components::Home::IndexPage, target: "world")
  end
end