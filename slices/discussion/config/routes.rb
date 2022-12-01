module Discussion
  class Routes < Hanami::Routes
    get "/cat/:id", to: "category.show"
    get "/th/:id", to: "thread.show"
    root to: "home.index"
  end
end
