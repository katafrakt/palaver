# frozen_string_literal: true

class Discussion::Actions::Home::Index < Palaver::Action
  include Discussion::Deps[
            repo: "repositories.categories"
          ]

  def handle(req, res)
    res.body = render(Discussion::Templates::Home::Index, categories: repo.all)
  end
end
