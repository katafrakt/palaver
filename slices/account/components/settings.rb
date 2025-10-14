module Account
  module Components
    module Settings
      def settings_layout(active:, &)
        title = case active
        when :account then "Account settings"
        when :profile then "Profile settings"
        end

        div(class: "columns") do
          div(class: "column is-one-quarter")
          div(class: "column") do
            heading2(title)
          end
        end

        div(class: "columns") do
          div(class: "column is-one-quarter") do
            div(class: "menu") do
              ul(class: "menu-list") do
                li do
                  a(class: (active == :account) ? "is-active" : "", href: "/account/settings/account") { "Settings" }
                end
                li do
                  a(class: (active == :profile) ? "is-active" : "", href: "/account/settings/profile") { "Profile" }
                end
              end
            end
          end

          div(class: "column") do
            yield
          end
        end
      end
    end
  end
end
