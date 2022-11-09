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
        render Detail.new("Topics", category.topic_count)
        raw " &middot; "
        render Detail.new("Messages", category.post_count)
        raw " &middot; "
        if category.latest_topic
        span do
          text "Last message by "
          a(href: "/") { category.latest_topic.last_post.author.nickname }
          whitespace
          text "in"
          whitespace
          a(href: "/") { category.latest_topic.title }
        end
        end
      end
    end
  end
end
