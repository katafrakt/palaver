# frozen_string_literal: true

require "stringex"

module Discussion
  module Utils
    # This is a code that actually creates a slugged value from a string.
    # It uses Stringex, which is great, but it's also slow. That's why it's being put into
    # a separate class, so we may replace in with something simpler yet efficient in tests.
    class SlugProvider
      def call(string)
        string.to_url
      end
    end
  end
end
