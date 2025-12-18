# frozen_string_literal: true

module Discussion
  module Events
    class ReplyAddedToThread < Dry::Struct
      include Palaver::Types

      attribute :thread_id, Integer
      attribute :author, Discussion::Entities::Author
      attribute :content, String
      attribute :message, Discussion::Entities::Message
    end
  end
end
