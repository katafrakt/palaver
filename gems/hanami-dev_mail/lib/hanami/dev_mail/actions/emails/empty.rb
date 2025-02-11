module Hanami
  module DevMail
    module Actions
      module Emails
        class Empty < Hanami::Action
          def handle(_req, res)
            res.render(view, layout: false)
          end
        end
      end
    end
  end
end
