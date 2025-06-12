# frozen_string_literal: true

class Discussion::Actions::Home::NewThreads < Discussion::Action
  include Discussion::Deps[queries: "queries.homepage"]

  def handle(_req, res)
    res.render(Discussion::Views::Home::NewThreads, threads: queries.new_threads)
  end
end
