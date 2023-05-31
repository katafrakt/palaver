# frozen_string_literal: true

class Discussion::Actions::Home::Recent < Discussion::Action
  include Discussion::Deps[query: "queries.homepage_recent"]

  def handle(_req, res)
    res.render(Discussion::Templates::Home::Recent, threads: query.call)
  end
end
