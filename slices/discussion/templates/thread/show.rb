class Discussion::Templates::Thread::Show < Palaver::View
  include Ui::Typography
  include Ui::Form
  include Discussion::Deps[
    "access_control",
    slugger: "utils.slugger"
  ]

  def template
    div do
      heading2(@thread.title)

      @pager.entries.each do |message|
        message_row(message)
      end

      if access_control.authorizer.authorized?(current_user, @thread, :reply)
        reply_form
      else
        render Discussion::Components::NoProfileWarning.new(current_user)
      end

      pagination
    end
  end

  private

  def message_row(message)
    article(class: "mt-5 mb-5 box columns") do
      div(class: "column is-one-quarter") do
        p(class: "is-size-4") do
          strong { message.author.nickname }
        end
        p(class: "image is-96x96 is-hidden-mobile mb-3 mt-3") do
          img(src: avatar_url(message))
        end
        p(class: "is-hidden-mobile is-size-7") do
          plain "Posts: "
          plain message.author.message_count
        end
      end

      div(class: "column") do
        div(class: "pb-2 mb-3", style: "border-bottom: solid 1px gray") do
          small { post_date(message) }
        end

        div(class: "content") { message.text }
      end
    end
  end

  def avatar_url(message)
    if message.author.avatar
      message.author.avatar_url
    else
      "https://bulma.io/images/placeholders/128x128.png"
    end
  end

  def post_date(message)
    message.posted_at.strftime("%Y-%m-%d %H:%M")
  end

  def thread_slug
    slugger.to_slug(Discussion::Entities::Thread::HASHIDS_NUM, @thread.title, @thread.id)
  end

  def reply_form
    render Ui::Components::Form.new(url: "/th/#{thread_slug}/reply") do
      hidden_field("_csrf_token", csrf_token)
      horizontal_field(label: "Write your reply", name: :reply, type: :textarea)
      render Ui::Components::Form::HorizontalSubmit.new(label: "Reply")
    end
  end

  def pagination
    nav(class: "pagination is-centered", role: "pagination", aria_label: "pagination") do
      ul(class: "pagination-list") do
        @pager.total_pages.times do |pg|
          page = pg + 1
          li do
            a(class: "pagination-link #{(page == @pager.current_page) ? "is-current" : nil}", aria_label: "Go to page #{page}", href: "/th/#{thread_slug}?page=#{page}") { plain page }
          end
        end
      end
    end
  end
end
