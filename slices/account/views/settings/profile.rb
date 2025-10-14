module Account
  module Views
    module Settings
      class Profile < Palaver::View
        include Ui::Typography
        include Account::Components::Settings
        include Deps[repo: "repositories.profile"]

        def view_template
          @profile = repo.by_account_id(current_user.id)

          settings_layout(active: :profile) do
            render Ui::Components::Form.new(url: "/account/settings/profile", multipart: true) do |form|
              form.csrf(csrf_token)

              form.section_title("Avatar")

              div(class: "field is-horizontal") do
                div(class: "field-label is-normal") do
                  label(class: "label") { "Current avatar" }
                end

                div(class: "field-body") do
                  if @profile.avatar_data
                    p(class: "image is-128x128 mb-3 mt-3") do
                      img(src: @profile.avatar.url)
                    end
                  end
                end
              end

              form.input(type: "hidden", value: nil, name: :avatar)
              form.horizontal_field(label: "Pick new", name: :avatar, type: :file)
              div(class: "is-flex pt-4") do
                form.submit("Save changes")
              end
            end
          end
        end
      end
    end
  end
end
