class Discussion::Components::CategoryRow < Phlex::HTML
  class Detail < Phlex::HTML
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
        render Detail.new("Threads", category.thread_count)
        unsafe_raw " &middot; "
        render Detail.new("Messages", category.message_count)
        if category.latest_thread
          unsafe_raw " &middot; "
          span do
            text "Last message by "
            a(href: "/") { most_recent_thread.last_message.author.nickname }
            whitespace
            text "in"
            whitespace
            a(href: "/") { most_recent_thread.title }
          end
        end
      end
    end
  end

  private

  def most_recent_thread
    category.latest_thread
  end
end
