# frozen_string_literal: true

class Account::Views::Settings::Auth < Palaver::View
  include Ui::Typography
  include Account::Components::Settings
  include Account::Deps[repo: "repositories.account"]

  def view_template
    @settings = repo.settings_by_user_id(current_user.id)

    settings_layout(active: :account) do
      render Ui::Components::Form.new(url: "/account/settings/account", multipart: true) do |form|
        form.csrf(csrf_token)
        form.horizontal_field(label: "Email", name: "email", value: @settings.email, disabled: true)

        form.section_title("Password reset", pad_top: true)
        form.horizontal_field(label: "Current password", name: "current_password", type: :password,
          error: @errors[:current_password], value: @values[:current_password])
        form.horizontal_field(label: "New password", name: "new_password", type: :password,
          error: @errors[:new_password], value: @values[:new_password])
        form.horizontal_field(label: "Confirm new password", name: "new_password_confirmation", type: :password,
          error: @errors[:new_password_confirmation], value: @values[:new_password_confirmation])

        div(class: "is-flex pt-4") do
          form.submit("Save changes")
        end
      end
    end
  end
end
