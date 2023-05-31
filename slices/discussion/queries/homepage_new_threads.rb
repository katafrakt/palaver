# frozen_string_literal: true

class Discussion::Queries::HomepageNewThreads
  include Discussion::Deps[repo: "repositories.thread"]

  def call
    repo.by_first_message.to_a
  end
end
