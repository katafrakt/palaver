class Discussion::Components::ThreadRow < Phlex::HTML
  include Discussion::Deps["utils.slugger"]

  def initialize(thread, slugger:)
    @thread = thread
    @slugger = slugger
  end

  def template
    slug = @slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, @thread.title, @thread.id)

    article(class: "mt-5 mb-5 media thread-row") do
      figure(class: "media-left") do
        p(class: "image is-64x64") do
          img(src: "https://bulma.io/images/placeholders/128x128.png")
        end
      end
      div(class: "media-content") do
        div(class: "content") do
          h4(class: "is-size-4") do
            a(href: "/th/#{slug}") { @thread.title }
            span(class: "ml-2 tag is-info is-light") { "Pinned" } if @thread.pinned
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
