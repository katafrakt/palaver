# frozen_string_literal: true

require_relative "envelope"
require "time"
require "securerandom"
require "pstore"

module Hanami
  module DevMail
    class Storage
      ENVELOPES_KEY = "envelopes"

      def initialize(file:, items_limit:)
        @store = PStore.new(file)
        @items_limit = items_limit
      end

      def envelopes
        @store.transaction do
          @store[ENVELOPES_KEY] || []
        end
      end

      def by_id(id)
        @store.transaction do
          @store[id]
        end
      end

      def add(mail)
        envelope = Envelope.new(
          subject: mail.subject,
          to: mail.to,
          sent_at: Time.now,
          id: SecureRandom.hex(15)
        )

        @store.transaction do
          @store[ENVELOPES_KEY] ||= []
          @store[ENVELOPES_KEY].unshift(envelope)
          @store[envelope.id] = mail
        end
      end

      def clear
        @store.transaction do
          envelopes = @store[ENVELOPES_KEY] || []

          envelopes.each do |envelope|
            @store.delete(envelope.id)
          end

          @store[ENVELOPES_KEY] = []
        end
      end
    end
  end
end
