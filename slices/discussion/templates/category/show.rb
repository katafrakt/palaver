class Discussion::Templates::Category::Show < Palaver::View
  def template
    div do
      h2(class: "is-size-2") { @category.name }

      if @threads.empty?
        p { "No threads" }
      else
        @threads.each do |topic|
          article(class: "mb-5") do
            h4(class: "is-size-4") do
              text topic.title
              small do
                span(class: "tag") { "Question" }
              end
            end
          end
        end
      end
    end
  end
end
