# frozen_string_literal: true

class Discussion::Actions::Home::Index < Palaver::Action
  include Discussion::Deps[
            repo: "repositories.categories"
          ]

  def handle(_req, res)
    categories = repo.homepage
    res.render(Discussion::Templates::Home::Index, categories: categories)
  end
end
