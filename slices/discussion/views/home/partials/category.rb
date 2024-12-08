class Discussion::Views::Home::Partials::Category < Phlex::HTML
  include Discussion::Deps["utils.slugger"]

  class Detail < Phlex::HTML
    def initialize(label, value)
      @label = label
      @value = value
    end

    def view_template
      span do
        strong { @label }
        plain ": #{@value}"
      end
    end
  end

  attr_reader :category

  def initialize(category:, slugger:)
    @category = category
    @slugger = slugger
  end

  def view_template
    slug = @slugger.to_slug(Discussion::Entities::Category::HASHIDS_NUM, category.name, category.id)

    article(class: "category mb-5") do
      h4(class: "is-size-4") do
        a(href: "/cat/#{slug}") { category.name }
      end

      div do
        render Detail.new("Threads", category.thread_count)
        raw safe(" &middot; ")
        render Detail.new("Messages", category.message_count)
        if category.latest_thread
          raw safe(" &middot; ")
          span do
            plain "Last message by "
            a(href: "/") { "Test" }
            whitespace
            plain "in"
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
