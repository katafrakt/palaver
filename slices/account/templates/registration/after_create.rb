class Account::Templates::Registration::AfterCreate < Phlex::HTML
  def initialize(account:)
    @account = account
  end

  def template
    article(class: "message is-warning") do
      div(class: "message-body") do
        "This should be an email, but we are just testing, so let's pretend it is."
      end
    end

    div do
      render Palaver::Components::Typography::Heading.new(level: 2, text: "Thank you for registering on Palaver")

      p do
        text "In order to confirm your account, please click on the following link: "
        a(href: "/account/confirm?id=#{@account.id}&token=#{@account.confirmation_token}") { "confirm account" }
        text "."
      end
    end
  end
end
