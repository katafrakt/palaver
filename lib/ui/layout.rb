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
          nav(class: "navbar", role: "navigation") do
            container do
              div(class: "navbar-brand") do
                div(class: "navbar-item") do
                  a(href: "/") { "Home" }
                end
              end

              div(class: "navbar-menu") do
                div(class: "navbar-end") do
                  if current_user&.signed_in?
                    div(class: "navbar-item has-dropdown is-hoverable") do
                      a(class: "navbar-link") { current_user.email }
                      div(class: "navbar-dropdown") do
                        a(class: "navbar-item", href: "/account/settings") { "Account settings" }
                        a(class: "navbar-item", href: "/profile") { "My Profile" }
                        a(class: "navbar-item", href: "/account/sign_out") { "Sign out" }
                      end
                    end
                  else
                    a(href: "/account/sign_in", class: "navbar-item") { "Sign in" }
                  end
                end
              end
            end
          end

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
    end

    def container(&)
      div(class: "container", &)
    end
  end
end
