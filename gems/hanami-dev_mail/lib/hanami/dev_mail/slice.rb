# lib/slice.rb

module Hanami
  module DevMail
    class Slice < Hanami::Slice
      config.root = __dir__
        config.actions.content_security_policy[:script_src] = "'unsafe-inline'"
        config.actions.content_security_policy[:frame_src] = "*"
    end
  end
end
