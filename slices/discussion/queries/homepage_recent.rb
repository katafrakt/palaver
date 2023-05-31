# frozen_string_literal: true

class Discussion::Queries::HomepageRecent
  include Discussion::Deps[repo: "repositories.thread"]

  def call
    repo.by_last_message.to_a
  end
end
