# frozen_string_literal: true

class Discussion::Actions::Home::Index < Discussion::Action
  include Discussion::Deps[query: "queries.homepage_categories"]

  def handle(_req, res)
    res.render(Discussion::Templates::Home::Index, categories: query.call)
  end
end
