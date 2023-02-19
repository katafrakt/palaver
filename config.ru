# frozen_string_literal: true

require "hanami/boot"
use Rack::Static, urls: ["/uploads"], root: "public"
run Hanami.app
