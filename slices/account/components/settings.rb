module Account
  module Components
    module Settings
      def settings_layout(active:, &)
        sidebar_link = lambda do |id, label, url|
          extra_class = (active == id) ? " active" : ""
          li(class: "nav-item") do
            a(class: "nav-link#{extra_class}", href: url) do
              span(class: "nav-link-title") { label }
            end
          end
        end

        div(class: "page") do
          aside(class: "navbar navbar-vertical navbar-expand-sm position-absolute", data_bs_theme: "light") do
            div(class: "container-fluid") do
              div(class: "collapse navbar-collapse", id: "sidebar-menu") do
                ul(class: "navbar-nav pt-lg-3") do
                  sidebar_link.call(:account, "Settings", "/account/settings/account")
                  sidebar_link.call(:profile, "Profile", "/account/settings/profile")
                end
              end
            end
          end

          div(class: "page-wrapper") do
            div(class: "page-body") do
              div(class: "container-xl") do
                yield
              end
            end
          end
        end
      end
    end
  end
end
