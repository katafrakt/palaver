# frozen_string_literal: true

class Discussion::Actions::Thread::Show < Discussion::Action
  include Discussion::Deps[
            repo: "repositories.thread"
          ]

  def handle(req, res)
    page = req.params[:page] || 1
    thread = repo.get(req.params[:id])
    pager = repo.paged_messages(thread.id, page.to_i)
    res.render(Discussion::Templates::Thread::Show, thread:, pager:)
  end
end
