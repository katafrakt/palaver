# frozen_string_literal: true

class Discussion::Actions::Category::Show < Discussion::Action
  include Discussion::Deps[
    repo: "repositories.category",
    slugger: "utils.slugger",
    thread_repo: "repositories.thread"
  ]

  def handle(req, res)
    id = slugger.decode_id(req.params[:id])
    category = repo.get(id)
    threads = thread_repo.by_category(category.id)
    res.render(Discussion::Views::Category::Show, category: category, threads: threads)
  end
end
