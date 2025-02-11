# frozen_string_literal: true

module Hanami
  module DevMail
    class Envelope < Struct.new(:subject, :to, :sent_at, :id)
    end
  end
end
