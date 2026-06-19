# frozen_string_literal: true

class Discussion::Actions::Home::NewThreads < Discussion::Action
  include Discussion::Deps[repo: "repositories.thread"]

  def handle(_req, res)
    res.render(Discussion::Views::Home::NewThreads, threads: repo.new_threads)
  end
end
