# frozen_string_literal: true

class Discussion::Actions::Home::Recent < Discussion::Action
  include Discussion::Deps[queries: "queries.homepage"]

  def handle(_req, res)
    res.render(Discussion::Views::Home::Recent, threads: queries.recent_threads)
  end
end
