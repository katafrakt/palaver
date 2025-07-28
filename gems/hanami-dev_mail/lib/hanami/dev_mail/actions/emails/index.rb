module Hanami
  module DevMail
    module Actions
      module Emails
        class Index < Hanami::Action
          def handle(req, res)
            storage = Hanami::DevMail::Storage.new(file: "/tmp/palaver-mails", items_limit: 20)
            res.render(view, envelopes: storage.envelopes, layout: false)
          end
        end
      end
    end
  end
end
