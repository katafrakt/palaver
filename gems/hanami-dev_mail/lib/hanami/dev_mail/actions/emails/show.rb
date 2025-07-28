module Hanami
  module DevMail
    module Actions
      module Emails
        class Show < Hanami::Action
          def handle(req, res)
            storage = Hanami::DevMail::Storage.new(file: "/tmp/palaver-mails", items_limit: 20)
            mail = storage.by_id(req.params[:id])
            res.render(view, mail:, layout: false)
          end
        end
      end
    end
  end
end
