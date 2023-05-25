# frozen_string_literal: true

# Fetches the category list for the homepage
class Discussion::Queries::HomepageCategories
  include Discussion::Deps[
            repo: "repositories.category"
          ]

  def call
    repo.homepage.map do |category|
      Discussion::Entities::Category.from_rom(category).tap do |entity|
        if category.latest_thread
          thread = Discussion::Entities::Thread.from_rom(category.latest_thread)
          entity.set_latest_thread(thread)
        end
      end
    end
  end
end
