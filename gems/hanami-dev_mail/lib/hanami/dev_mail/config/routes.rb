module Hanami
  module DevMail
    class Routes < Hanami::Routes
      get "/empty", to: "emails.empty"
      post "/clear", to: "emails.clear"
      get "/:id/metadata", to: "emails.metadata", as: :email_metadata
      get "/:id/content", to: "emails.content", as: :email_content
      get "/:id", to: "emails.show", as: :email
      get "/", to: "emails.index"
    end
  end
end
