module Hanami
  module DevMail
    module Actions
      module Emails
        class Metadata < Hanami::Action
          def handle(req, res)
            storage = Hanami::DevMail::Storage.new(file: "/tmp/palaver-mails", items_limit: 20)
            mail = storage.by_id(req.params[:id])

            res.format = :json
            res.body = {
              subject: mail.subject,
              from: mail.from,
              to: mail.to,
              sent_at: mail.date&.to_s
            }.to_json
          end
        end
      end
    end
  end
end
