class Discussion::Templates::Home::Index < Phlex::HTML
  attr_reader :categories

  def initialize(categories:)
    @categories = categories
  end

  def template
    div do
      h4(class: "is-size-2") { "Categories" }
      div(class: "section") do
        categories.each do |category|
          render Discussion::Components::CategoryRow.new(category: category)
        end
      end
    end
  end
end
