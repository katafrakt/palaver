module Account
  class Routes < Hanami::Routes
    get "/register", to: "registration.new"
    post "/register", to: "registration.create"
    get "/confirm", to: "registration.confirm"

    get "/sign_in", to: "sign_in.new"
    post "/sign_in", to: "sign_in.create"
    get "/sign_out", to: "sign_in.destroy"

    get "/settings/:tab", to: "settings.show"
    post "/settings/account", to: "settings.update_account"
    post "/settings/profile", to: "settings.update_profile"
  end
end
