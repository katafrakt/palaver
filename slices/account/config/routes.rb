module Account
  class Routes < Hanami::Routes
    get "/register", to: "registration.new"
  end
end
