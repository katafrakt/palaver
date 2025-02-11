# frozen_string_literal: true

module Hanami
  module DevMail
    # Extension for Hanami::Routes to make it easier to mount the DevMail slice
    module RouterExtension
      # Mount the DevMail slice at the specified URL
      # This provides a cleaner syntax for mounting the DevMail slice
      # in a Hanami::Routes class
      #
      # @param [String] url The URL where the DevMail slice will be mounted
      # @return [void]
      def mount_dev_mail(at:)
        Hanami::DevMail.config.url_prefix = at
        slice(Hanami::DevMail::SLICE_NAME, at:)
      end
    end
  end
end

# Apply the extension immediately when this file is loaded
# if defined?(Hanami::Routes)
#  Hanami::Routes.include(Hanami::DevMail::RouterExtension)
#end
