# frozen_string_literal: true

# The CurrentUser entity represents an actor interacting with the forum in the
# context of the discussion. It is amalgamation of data from account and a profile,
# as well as some data related to access limitations.
module Discussion
  module Entities
    class CurrentUser < Dry::Struct
      ANONYMOUS = "Anonymous"

      include Palaver::Types
      include Palaver::AvatarUploader::Attachment(:avatar)

      attribute :account_id, ID.optional
      attribute :profile_id, ID.optional
      attribute? :email, String
      attribute :nickname, String
      attribute :message_count, Integer

      def self.build_anonymous
        new(
          account_id: nil,
          profile_id: nil,
          nickname: ANONYMOUS,
          message_count: 0
        )
      end

      # Builds a representation of a user that does not have a profile set up yet
      def self.build_profileless(account_id)
        new(
          account_id:,
          profile_id: nil,
          nickname: ANONYMOUS,
          message_count: 0
        )
      end

      def to_author
        Discussion::Entities::Author.new(
          id: profile_id,
          nickname:,
          account_id:,
          message_count:
        )
      end

      def profile_set_up? = !profile_id.nil?

      def signed_in? = !account_id.nil?

      # Access control

      def subject_id = "user:#{profile_id}"

      def subject_type = :user

      def subject_sids
        [].tap do |sids|
          sids << :authenticated if signed_in?
          sids << :no_profile unless profile_set_up?
        end
      end
    end
  end
end
