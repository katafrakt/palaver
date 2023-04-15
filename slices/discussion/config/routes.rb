module Discussion
  class Routes < Hanami::Routes
    get "/cat/:id", to: "category.show"
    get "/th/:id", to: "thread.show"
    post "/th/:id/reply", to: "thread.reply"
    get "/profile", to: "profile.form"
    post "/profile", to: "profile.save"

    get "/recent", to: "home.recent"
    get "/new_threads", to: "home.new_threads"
    root to: "home.index"
  end
end
