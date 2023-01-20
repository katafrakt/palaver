module Discussion
  module Entities
    class User < Dry::Struct
      attribute :nickname, Palaver::Types::String
      attribute :email, Palaver::Types::String
      attribute :message_count, Palaver::Types::Integer
    end
  end
end
