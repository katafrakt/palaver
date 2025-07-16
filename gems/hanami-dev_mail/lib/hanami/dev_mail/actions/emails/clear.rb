# frozen_string_literal: true

module Hanami
  module DevMail
    module Actions
      module Emails
        class Clear < Hanami::Action
          def handle(request, response)
            storage = Storage.new(
              file: "/tmp/palaver-mails",
              items_limit: 20
            )

            storage.clear

            response.redirect_to Hanami::DevMail.url_prefix
          end
        end
      end
    end
  end
end
