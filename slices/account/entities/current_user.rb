module Account
  module Entities
    class CurrentUser
      attr_reader :attributes

      def initialize(attributes)
        @attributes = attributes.slice(:id, :email, :confirmation_token, :confirmed_at, :registered_at)
      end

      def [](name)
        attributes[name]
      end

      def id = attributes[:id]
      def email = attributes[:email]
      def signed_in? = true

      def subject_id =  "user:#{id}"
      def subject_type = :user
      def subject_sids = [:authenticated]
    end
  end
end
