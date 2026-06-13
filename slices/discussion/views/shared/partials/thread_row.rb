# frozen_string_literal: true

class Discussion::Views::Shared::Partials::ThreadRow < Phlex::HTML
  include Discussion::Deps["utils.slugger"]

  def initialize(thread, slugger:)
    @thread = thread
    @slugger = slugger
  end

  def view_template
    slug = @slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, @thread.title, @thread.id)

    div(class: "card mb-2") do
      div(class: "card-body") do
        div(class: "row row-0 flex-fill") do
          div(class: "col-md-8") do
            h4(class: "is-size-4") do
              a(href: "/th/#{slug}") { @thread.title }
              span(class: "ms-2 badge bg-azure text-azure-fg") { "Pinned" } if @thread.pinned
            end
          end

          div(class: "col") do
            nav(class: "level is-mobile") do
              span do
                strong { "Replies: " }
                plain @thread.message_count - 1
              end
            end
          end
        end
      end
    end
  end
end
