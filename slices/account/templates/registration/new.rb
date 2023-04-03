# frozen_string_literal: true

class Account::Templates::Registration::New < Palaver::View
  include Ui::Typography
  include Ui::Form

  def template
    div do
      heading2("Register new account")
      render Ui::Components::Form.new(url: "/account/register") do
        hidden_field("_csrf_token", csrf_token)
        horizontal_field(label: "Email", name: "email", placeholder: "your-email@example.com", value: @values[:email], error: @errors[:email])
        horizontal_field(label: "Password", name: "password", type: :password, value: @values[:password], error: @errors[:password])
        horizontal_field(label: "Password confirmation", name: "password_confirmation", type: :password, value: @values[:password_confirmation], error: @errors[:password_confirmation])
        render Ui::Components::Form::HorizontalSubmit.new(label: "Register")
      end
    end
  end
end
