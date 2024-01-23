# frozen_string_literal: true

module Discussion
  module Entities
    class Profile < Dry::Struct
      include Palaver::Types
      include Palaver::AvatarUploader::Attachment(:avatar)

      attribute :id, ID
      attribute :nickname, String
      attribute :account_id, Integer.optional
      attribute? :message_count, Integer.optional
    end
  end
end
