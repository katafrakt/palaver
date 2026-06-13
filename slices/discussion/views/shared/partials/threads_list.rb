# frozen_string_literal: true

module Discussion
  module Views
    module Shared
      module Partials
        class ThreadsList < Phlex::HTML
          def initialize(threads, **_opts)
            @threads = threads
            @slugger = Utils::Slugger.new
          end

          def view_template
            div(class: "card") do
              div(class: "card-table table-responsive") do
                table(class: "table table-vcenter") do
                  tbody do
                    @threads.each do |thread|
                      slug = @slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, thread.title, thread.id)

                      tr(class: "table-light") do
                        td(class: "w-8") do
                          h4 do
                            if thread.pinned
                              span(class: "badge bg-azure text-azure-fg") { "Pinned" }
                              br
                            end
                            a(href: "/th/#{slug}") { thread.title }
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
