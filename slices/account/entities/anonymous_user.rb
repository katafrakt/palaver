module Account
  module Entities
    class AnonymousUser
      def signed_in? = false
      def subject_id =  "user:anonymous"
      def subject_type = :user
      def subject_sids = [:anonymous]
    end
  end
end
