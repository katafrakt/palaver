module Discussion
  class Routes < Hanami::Routes
    get "/cat/:id", to: "category.show"
    root to: "home.index"
  end
end
