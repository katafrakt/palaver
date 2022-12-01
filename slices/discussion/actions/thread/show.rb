# frozen_string_literal: true

class Discussion::Actions::Thread::Show < Discussion::Action
  include Discussion::Deps[
            repo: "repositories.threads"
          ]

  def handle(req, res)
    page = req.params[:page] || 1
    thread = repo.get(req.params[:id])
    messages = repo.paged_messages(thread.id, page)
    res.render(Discussion::Templates::Thread::Show, thread: thread, messages: messages)
  end
end
