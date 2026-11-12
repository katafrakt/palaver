class Discussion::Views::Category::Show < Palaver::View
  include Discussion::Deps[
    repo: "repositories.category",
    thread_repo: "repositories.thread"
  ]

  def initialize(id:, repo:, thread_repo:)
    @category = repo.get(id)
    @threads = thread_repo.by_category(@category.id)
  end

  def view_template
    div(class: "page-header") do
      h2(class: "page-title") { @category.name }
    end

    div(class: "page-body") do
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
