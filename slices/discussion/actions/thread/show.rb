# frozen_string_literal: true

class Discussion::Actions::Thread::Show < Discussion::Action
  include Discussion::Deps[
    repo: "repositories.thread",
    slugger: "utils.slugger"
          ]

  def handle(req, res)
    id = slugger.decode_id(req.params[:id])
    page = req.params[:page] || 1
    thread = repo.get(id)
    pager = repo.paged_messages(thread.id, page.to_i)
    res.render(Discussion::Templates::Thread::Show, thread:, pager:)
  end
end
