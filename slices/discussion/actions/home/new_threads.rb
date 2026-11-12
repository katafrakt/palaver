# frozen_string_literal: true

class Discussion::Actions::Home::NewThreads < Discussion::Action
  include Discussion::Deps[repo: "repositories.thread"]

  def handle(_req, res)
    res[:threads] = repo.new_threads
  end
end
