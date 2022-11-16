class Discussion::Templates::Category::Show < Phlex::HTML
  attr_reader :category, :topics

  def initialize(category:, topics:)
    @category = category
    @topics = topics
  end

  def template
    div do
      h2(class: "is-size-2") { category.name }

      topics.each do |topic|
        article(class: "mb-5") do
          h4(class: "is-size-4") do
            text topic.title
            small do
              span(class: "tag") { "Question" }
            end
          end
        end
      end
    end
  end
end
