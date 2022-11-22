# frozen_string_literal: true

class Account::Templates::SignIn::New < Phlex::HTML
  def initialize(values: {}, errors: {}, csrf_token:)
    @values = values
    @errors = errors
    @token = token
  end

  def template
    div do
    render Palaver::Components::Typography::Heading.new(level: 2, text: "Sign in")
    div(class: "columns") do
      div(class: "column is-two-thirds") do
        div do
          render Palaver::Components::Form.new(url: "/account/sign_in") do
            input(name: "_csrf_token", value: @token)
            render Palaver::Components::Form::HorizontalField.new(label: "Email", name: "email", placeholder: "your-email@domain.com")
            render Palaver::Components::Form::HorizontalField.new(label: "Password", name: "password", type: :password, value: @values[:password], error: @errors[:password])
            render Palaver::Components::Form::HorizontalSubmit.new(label: "Sign in")
          end
        end
      end

      div(class: "column is-one-third") do
        p do
          text "Don't have an account yet?"
          whitespace
          a(href: "/account/register") { "Register here" }
          text "."
        end
      end
    end
    end
  end
end
