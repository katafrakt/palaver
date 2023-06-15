# frozen_string_literal: true

class Discussion::Actions::Category::Show < Discussion::Action
  include Discussion::Deps[
    repo: "repositories.category",
    slugger: "utils.slugger",
    query: "queries.threads_in_category"
  ]

  def handle(req, res)
    id = slugger.decode_id(req.params[:id])
    category = repo.get(id)
    threads = query.call(category.id)
    res.render(Discussion::Templates::Category::Show, category: category, threads: threads)
  end
end
