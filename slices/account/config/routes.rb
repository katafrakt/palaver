module Account
  class Routes < Hanami::Routes
    get "/register", to: "registration.new"
    post "/register", to: "registration.create"
    get "/confirm", to: "registration.confirm"

    get "/sign_in", to: "sign_in.new"
    post "/sign_in", to: "sign_in.create"
  end
end
