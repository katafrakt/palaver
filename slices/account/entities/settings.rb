# frozen_string_literal: true

class Account::Entities::Settings < ROM::Struct
  include Palaver::Types
  include Palaver::AvatarUploader::Attachment(:avatar)

  attribute :user_id, Integer
  attribute :email, String
  attribute :nickname, String.optional

  def self.from_rom(user)
    new(
      user_id: user.id,
      email: user.email,
      nickname: user.profile&.nickname
    )
  end
end
