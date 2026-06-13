module Ui
  class Layout < Palaver::View
    def initialize(view, context, args)
      super(context, args)
      @view = view
    end

    def view_template
      html(data: {theme: "light"}) do
        head do
          title { "Palaver" }
          link rel: "stylesheet", href: asset_url("app.css")
          meta(name: "viewport", content: "width=device-width, initial-scale=1")
        end

        body do
          header(class: "navbar navbar-expand-md d-print-none", role: "navigation") do
            container do
              div(class: "navbar-brand") do
                div(class: "navbar-item") do
                  a(href: "/") { "Palaver" }
                end
              end

              div(class: "navbar-nav flex-row order-md-last ms-auto") do
                if current_user&.signed_in?
                  div(class: "nav-item dropdown") do
                    a(class: "nav-link d-flex lh-1 text-reset", href: "#", data_bs_toggle: "dropdown") do
                      div(class: "d-xl-block ps-2") do
                        current_user.email
                      end
                    end
                    div(class: "dropdown-menu dropdown-menu-end dropdown-menu-arrow") do
                      a(class: "dropdown-item", href: "/account/settings/account") { "Account settings" }
                      a(class: "dropdown-item", href: "/profile") { "My Profile" }
                      a(class: "dropdown-item", href: "/account/sign_out") { "Sign out" }
                    end
                  end
                else
                  div(class: "navbar-item") do
                    a(href: "/account/sign_in", class: "nav-link nav-link-title") { "Sign in" }
                  end
                end
              end
            end
          end

          div(class: "page-wrapper") do
            div(class: "page-body") do
              container do
                if flash && flash[:error]
                  article(class: "message is-danger") do
                    div(class: "message-body") { flash[:error] }
                  end
                end

                if flash && flash[:success]
                  article(class: "message is-success") do
                    div(class: "message-body") { flash[:success] }
                  end
                end

                section(class: "section") do
                  render @view.new(context, **args)
                end
              end
            end
          end

          script(src: asset_url("app.js"))
        end
      end
    end

    def container(&)
      div(class: "container-xl", &)
    end
  end
end
