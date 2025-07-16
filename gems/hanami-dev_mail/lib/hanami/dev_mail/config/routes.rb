module Hanami
  module DevMail
    class Routes < Hanami::Routes
      get "/empty", to: "emails.empty"
      post "/clear", to: "emails.clear"
      get "/:id", to: "emails.show", as: :email
      get "/", to: "emails.index"
    end
  end
end
