module Discussion
  class Routes < Hanami::Routes
    get "/cat/:id", to: "category.show"
    get "/th/:id", to: "thread.show"
    post "/th/:id/reply", to: "thread.reply"
    root to: "home.index"
  end
end
