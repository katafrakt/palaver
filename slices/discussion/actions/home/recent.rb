# frozen_string_literal: true

class Discussion::Actions::Home::Recent < Discussion::Action
  include Discussion::Deps[repo: "repositories.thread"]

  def handle(_req, res)
    threads = repo.recently_updated
    res.render(Discussion::Templates::Home::Recent, threads:)
  end
end
