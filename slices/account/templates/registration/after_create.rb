class Account::Templates::Registration::AfterCreate < Palaver::View
  include Ui::Typography

  def template
    article(class: "message is-warning") do
      div(class: "message-body") do
        "This should be an email, but we are just testing, so let's pretend it is."
      end
    end

    div do
      heading2("Thank you for registering on Palaver")

      p do
        plain "In order to confirm your account, please click on the following link: "
        a(href: "/account/confirm?id=#{@account.id}&token=#{@account.confirmation_token}") { "confirm account" }
        plain "."
      end
    end
  end
end
