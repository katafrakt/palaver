# frozen_string_literal: true

class Discussion::Actions::Home::Index < Discussion::Action
  include Discussion::Deps[queries: "queries.homepage"]

  def handle(_req, res)
    res.render(Discussion::Views::Home::Index, categories: queries.category_list)
  end
end
