# frozen_string_literal: true

class Discussion::Actions::Home::Recent < Discussion::Action
  include Discussion::Deps[repo: "repositories.thread"]

  def handle(_req, res)
    res[:threads] = repo.recent_threads
  end
end
