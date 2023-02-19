# frozen_string_literal: true

module Discussion
  module Entities
    class Profile < ROM::Struct
      include Palaver::AvatarUploader::Attachment(:avatar)
    end
  end
end
