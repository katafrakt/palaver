# frozen_string_literal: true

class Discussion::Entities::Message < Dry::Struct
  class Author < Dry::Struct
    include Palaver::Types
    include Palaver::AvatarUploader::Attachment(:avatar)

    attribute :nickname, String
    attribute :id, Integer
    attribute :message_count, Integer.optional
    attribute :avatar_data, String.optional
  end

  include Palaver::Types

  attribute :id, Integer
  attribute :text, String
  attribute :posted_at, Time
  attribute :author, Author

  def self.from_rom(record)
    author = Author.new(record.author.to_h)
    new(record.to_h.merge(author: author))
  end
end
