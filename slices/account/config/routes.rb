module Account
  class Routes < Hanami::Routes
    get "/register", to: "registration.new"
    post "/register", to: "registration.create"
    get "/confirm", to: "registration.confirm"
  end
end
