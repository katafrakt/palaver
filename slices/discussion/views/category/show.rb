class Discussion::Views::Category::Show < Palaver::View
  def template
    div do
      h2(class: "is-size-2") { @category.name }

      if @threads.empty?
        p { "No threads" }
      else
        @threads.each do |thread|
          render Discussion::Views::Shared::Partials::ThreadRow.new(thread)
        end
      end
    end
  end
end
