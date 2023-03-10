# frozen_string_literal: true

require "verifica"

module Discussion
  class AccessControl
    class Thread
      def call(thread, **)
        Verifica::Acl.build do |acl|
          acl.allow :authenticated, [:reply]
          acl.deny :no_profile, [:reply]
        end
      end
    end

    def authorizer
      Verifica.authorizer do |config|
        config.register_resource :thread, [:reply], Thread.new
      end
    end
  end
end
