# frozen_string_literal: true

class Discussion::Queries::HomepageRecent
  include Discussion::Deps[repo: "repositories.thread"]

  def call
    repo.recently_updated
  end
end
