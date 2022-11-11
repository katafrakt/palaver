# frozen_string_literal: true

class Discussion::Actions::Category::Show < Palaver::Action
  include Discussion::Deps[
    repo: "repositories.categories",
    topic_repo: "repositories.topics"
  ]

  def handle(req, res)
    category = repo.get(req.params[:id])
    topics = topic_repo.by_category(category.id)
    res.body = render(Discussion::Templates::Category::Show, category: category, topics: topics)
  end
end
