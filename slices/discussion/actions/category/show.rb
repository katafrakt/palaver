# frozen_string_literal: true

class Discussion::Actions::Category::Show < Discussion::Action
  include Discussion::Deps[
    repo: "repositories.category",
    threads_repo: "repositories.thread",
    slugger: "utils.slugger"
  ]

  def handle(req, res)
    id = slugger.decode_id(req.params[:id])
    category = repo.get(id)
    threads = threads_repo.by_category(category.id)
    res.render(Discussion::Templates::Category::Show, category: category, threads: threads)
  end
end
