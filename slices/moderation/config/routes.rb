module Moderation
  class Routes < Hanami::Routes
    get "/thread/:id/pin", to: "thread.pin"
  end
end
