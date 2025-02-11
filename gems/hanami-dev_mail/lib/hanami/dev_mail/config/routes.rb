module Hanami
  module DevMail
    class Routes < Hanami::Routes
      get "/empty", to: "emails.empty"
      get "/:id", to: "emails.show", as: :email
      get "/", to: "emails.index"
    end
  end
end
