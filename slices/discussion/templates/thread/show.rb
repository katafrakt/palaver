class Discussion::Templates::Thread::Show < Palaver::View
  include Ui::Typography
  include Ui::Form
  include Discussion::Deps["acl"]

  def template
    div do
      heading2(@thread.title)

      @messages.each do |message|
        message_row(message)
      end

      if acl.authorizer.authorized?(current_user, @thread, :reply)
        reply_form
      end
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
          img(src: "https://bulma.io/images/placeholders/128x128.png")
        end
        p(class: "is-hidden-mobile is-size-7") do
          text "Posts: "
          text message.author.message_count
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

  def post_date(message)
    message.posted_at.strftime("%Y-%m-%d %H:%M")
  end

  def reply_form
    render Palaver::Components::Form.new(url: "/th/#{@thread.id}/reply") do
      hidden_field("_csrf_token", csrf_token)
      horizontal_field(label: "Write your reply", name: :reply, type: :textarea)
      render Palaver::Components::Form::HorizontalSubmit.new(label: "Reply")
    end
  end
end
