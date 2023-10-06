# frozen_string_literal: true

class Account::Views::Settings::Show < Palaver::View
  include Ui::Typography

  def template
    heading2("Account settings")
    render Ui::Components::Form.new(url: "/account/settings", multipart: true) do |form|
      form.csrf(csrf_token)
      render Ui::Components::Columns.new do |columns|
        columns.column do
          form.horizontal_field(label: "Email", name: "email", value: @settings.email, disabled: true)
          form.horizontal_field(label: "Name", name: "name", value: @settings.nickname, disabled: true)

          form.section_title("Password reset", pad_top: true)
          form.horizontal_field(label: "Current password", name: "current_password", type: :password,
            error: @errors[:current_password], value: @values[:current_password])
          form.horizontal_field(label: "New password", name: "new_password", type: :password,
            error: @errors[:new_password], value: @values[:new_password])
          form.horizontal_field(label: "Confirm new password", name: "new_password_confirmation", type: :password,
            error: @errors[:new_password_confirmation], value: @values[:new_password_confirmation])
        end

        columns.column do
          form.section_title("Avatar")

          if @settings.avatar_data
            p(class: "image is-128x128 mb-3 mt-3") do
              img(src: @settings.avatar.url)
            end
          end

          form.input(type: "hidden", value: nil, name: :avatar)
          form.horizontal_field(label: "Pick new", name: :avatar, type: :file)
        end
      end

      div(class: "is-flex is-justify-content-center pt-4") do
        form.submit("Save changes")
      end
    end
  end
end
