# frozen_string_literal: true

module Discussion
  module Events
    class ThreadCreated < Dry::Struct
      include Palaver::Types

      attribute :category_id, Integer
      attribute :creator, Discussion::Entities::Author
      attribute :title, String
      attribute :content, String
    end
  end
end
