# frozen_string_literal: true

class Discussion::Actions::Home::Index < Discussion::Action
  include Discussion::Deps[repo: "repositories.category"]

  def handle(_req, res)
    res[:categories] = repo.list
  end
end
