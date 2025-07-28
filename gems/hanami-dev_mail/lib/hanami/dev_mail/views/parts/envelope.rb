module Hanami
  module DevMail
    module Views
      module Parts
        class Envelope < Hanami::View::Part
          def url
            prefix = Hanami::DevMail.url_prefix
            File.join(prefix, Hanami::DevMail::Slice["routes"].path(:email, id: value.id))
          end
        end
      end
    end
  end
end
