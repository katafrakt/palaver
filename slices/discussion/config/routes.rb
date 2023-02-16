module Discussion
  class Routes < Hanami::Routes
    get "/cat/:id", to: "category.show"
    get "/th/:id", to: "thread.show"
    post "/th/:id/reply", to: "thread.reply"
    get "/profile", to: "profile.form"
    post "/profile", to: "profile.save"
    root to: "home.index"
  end
end
