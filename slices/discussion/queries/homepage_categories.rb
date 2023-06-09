# frozen_string_literal: true

# Fetches the category list for the homepage
class Discussion::Queries::HomepageCategories
  include Discussion::Deps[repo: "repositories.category"]

  def call
    repo.all_with_last_thread.map do |category|
      Discussion::Entities::Category.from_rom(category)
    end
  end
end
