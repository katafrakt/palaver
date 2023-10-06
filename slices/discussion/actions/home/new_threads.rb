# frozen_string_literal: true

class Discussion::Actions::Home::NewThreads < Discussion::Action
  include Discussion::Deps[query: "queries.homepage_new_threads"]

  def handle(_req, res)
    res.render(Discussion::Views::Home::NewThreads, threads: query.call)
  end
end
