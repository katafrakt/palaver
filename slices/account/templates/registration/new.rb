# frozen_string_literal: true

class Account::Templates::Registration::New < Phlex::HTML
  def initialize(values: {}, errors: {})
    @values = values
    @errors = errors
  end

  def template
    div do
      render Palaver::Components::Typography::Heading.new(level: 2, text: "Register new account")
      render Palaver::Components::Form.new(url: "/account/register") do
        render Palaver::Components::Form::HorizontalField.new(label: "Email", name: "email", placeholder: "your-email@example.com", value: @values[:email], error: @errors[:email])
        render Palaver::Components::Form::HorizontalField.new(label: "Password", name: "password", type: :password, value: @values[:password], error: @errors[:password])
        render Palaver::Components::Form::HorizontalField.new(label: "Password confirmation", name: "password_confirmation", type: :password, value: @values[:password_confirmation], error: @errors[:password_confirmation])
        render Palaver::Components::Form::HorizontalSubmit.new(label: "Register")
      end
    end
  end
end
