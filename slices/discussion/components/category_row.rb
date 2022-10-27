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
    article(class: 'category mb-5') do
      h4(class: "is-size-4") do 
        a(href: "/") { category.title }
      end

      div do
        render Detail.new("Topics", category.num_topics)
        raw " &middot; "
        render Detail.new("Posts", category.num_posts)
        raw " &middot; "
        span do
          text "Last post by "
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