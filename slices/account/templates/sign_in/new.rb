# frozen_string_literal: true

require "ui/typography"

class Account::Templates::SignIn::New < Palaver::View
  include ::Ui::Typography
  include ::Ui::Form

  def template
    div do
      heading2("Sign in")
      div(class: "columns") do
        div(class: "column is-two-thirds") do
          div do
            render Palaver::Components::Form.new(url: "/account/sign_in") do
              hidden_field("_csrf_token", csrf_token)
              horizontal_field(label: "Email", name: "email", placeholder: "your-email@domain.com")
              horizontal_field(label: "Password", name: "password", type: :password,
                value: @values[:password], error: @errors[:password])
              render Palaver::Components::Form::HorizontalSubmit.new(label: "Sign in")
            end
          end
        end

        div(class: "column is-one-third") do
          p do
            plain "Don't have an account yet?"
            whitespace
            a(href: "/account/register") { "Register here" }
            plain "."
          end
        end
      end
    end
  end
end
