# frozen_string_literal: true

class Discussion::Actions::Home::Index < Discussion::Action
  include Discussion::Deps[repo: "repositories.category"]

  def handle(_req, res)
    res.render(Discussion::Views::Home::Index, categories: repo.list)
  end
end
