# frozen_string_literal: true

class Discussion::Actions::Thread::Show < Discussion::Action
  include Discussion::Deps[
    repo: "repositories.thread",
    slugger: "utils.slugger",
    query: "queries.thread_messages_page"
  ]

  def handle(req, res)
    id = slugger.decode_id(req.params[:id])
    page = req.params[:page] || 1
    result = query.call(id, page)

    res.render(Discussion::Views::Thread::Show, thread: result[:thread], pager: result[:pager])
  end
end
