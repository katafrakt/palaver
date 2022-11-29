# frozen_string_literal: true

class Discussion::Actions::Category::Show < Discussion::Action
  include Discussion::Deps[
    repo: "repositories.categories",
    threads_repo: "repositories.threads"
  ]

  def handle(req, res)
    category = repo.get(req.params[:id])
    threads = threads_repo.by_category(category.id)
    res.render(Discussion::Templates::Category::Show, category: category, threads: threads)
  end
end
