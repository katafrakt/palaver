# frozen_string_literal: true

class Discussion::Views::Shared::Partials::ThreadRow < Phlex::HTML
  def initialize(thread)
    @thread = thread
    @slugger = Discussion::Utils::Slugger.new
  end

  def view_template
    slug = @slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, @thread.title, @thread.id)

    div(class: "card mb-2") do
      div(class: "card-body") do
        div(class: "row row-0 flex-fill") do
          div(class: "col-md-8") do
            h4(class: "is-size-4") do
              a(href: "/th/#{slug}") { @thread.title }
              span(class: "ms-2 badge bg-azure text-azure-fg") { "Pinned" } if @thread.pinned?
            end
          end

          div(class: "col") do
            nav(class: "level is-mobile") do
              span do
                strong { "Replies: " }
                plain @thread.replies
              end
            end
          end
        end
      end
    end
  end
end
