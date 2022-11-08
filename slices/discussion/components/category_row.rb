class Discussion::Components::CategoryRow < Phlex::View
  class Detail < Phlex::View
    def initialize(label, value)
      @label = label
      @value = value
    end

    def template
      span do
        strong { @label }
        text ": #{@value}"
      end
    end
  end

  attr_reader :category

  def initialize(category:)
    @category = category
  end

  def template
    article(class: "category mb-5") do
      h4(class: "is-size-4") do
        a(href: "/cat/#{category.id}") { category.name }
      end

      div do
        render Detail.new("Topics", category.topics.size)
        raw " &middot; "
        render Detail.new("Messages", 129)
        raw " &middot; "
        span do
          text "Last message by "
          a(href: "/") { "@geronimo" }
          whitespace
          text "in"
          whitespace
          a(href: "/") { "What's going on here?" }
        end
      end
    end
  end
end
