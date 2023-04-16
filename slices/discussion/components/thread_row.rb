class Discussion::Components::ThreadRow < Phlex::HTML
  def initialize(thread)
    @thread = thread
  end

  def template
    article(class: "mt-5 mb-5 media thread-row") do
      figure(class: "media-left") do
        p(class: "image is-64x64") do
          img(src: "https://bulma.io/images/placeholders/128x128.png")
        end
      end
      div(class: "media-content") do
        div(class: "content") do
          h4(class: "is-size-4") do
            a(href: "/th/#{@thread.id}") { @thread.title }
            span(class: "ml-2 tag is-info is-light") { "Pinned " } if @thread.pinned
          end
        end

        nav(class: "level is-mobile") do
          span do
            strong { "Replies: " }
            plain @thread.messages.size - 1
          end
        end
      end
    end
  end
end
