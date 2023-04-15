# frozen_string_literal: true

class Discussion::Actions::Home::NewThreads < Discussion::Action
  include Discussion::Deps[repo: "repositories.thread"]

  def handle(_req, res)
    threads = repo.newest_threads
    res.render(Discussion::Templates::Home::NewThreads, threads:)
  end
end
