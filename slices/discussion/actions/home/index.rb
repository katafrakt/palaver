# frozen_string_literal: true

Category = Struct.new(:title, :num_topics, :num_posts)

class Discussion::Actions::Home::Index < Palaver::Action
  include Discussion::Deps[
            repo: 'repositories.categories'
          ]

  def handle(req, res)
    categories = [
      Category.new("Announcements", 10, 102),
      Category.new("Random chat", 36, 2137)
    ]
    res.body = render(Discussion::Templates::Home::Index, categories: repo.all)
  end
end