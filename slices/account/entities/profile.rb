# frozen_string_literal: true

module Account
  module Entities
    class Profile < ROM::Struct
      include Palaver::Types
      include Palaver::AvatarUploader::Attachment(:avatar)

      attribute :id, Integer
      attribute :nickname, String.optional
      attribute :avatar_data, String.optional
    end
  end
end
