# frozen_string_literal: true

class Discussion::Templates::Profile::Form < Palaver::View
  include Ui::Typography
  include Ui::Form

  def template
    div do
      heading2("Create your profile")
      render Ui::Components::Form.new(url: "/profile", multipart: true) do
        hidden_field("_csrf_token", csrf_token)
        unless @profile
          field_info { "User name is your unique identifier accross the forum. It has to be unique and cannot be changed later." }
          horizontal_field(label: "User name", name: "username", value: @values[:username], error: @errors[:username])
        end
        input(type: "hidden", value: nil, name: :avatar)
        horizontal_field(label: "Avatar", name: :avatar, type: :file)
        label = @profile ? "Update profile" : "Set up your profile"
        render Ui::Components::Form::HorizontalSubmit.new(label:)
      end
    end
  end
end
