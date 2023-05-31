# frozen_string_literal: true

class Discussion::Queries::HomepageNewThreads
  include Discussion::Deps[repo: "repositories.thread"]

  def call
    repo.newest_threads
  end
end
