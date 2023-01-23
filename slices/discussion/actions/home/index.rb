# frozen_string_literal: true

class Discussion::Actions::Home::Index < Discussion::Action
  include Discussion::Deps[repo: "repositories.category"]

  def handle(_req, res)
    categories = repo.homepage
    res.render(Discussion::Templates::Home::Index, categories: categories)
  end
end
