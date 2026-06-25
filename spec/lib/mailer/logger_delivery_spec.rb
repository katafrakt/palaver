# frozen_string_literal: true

require "spec_helper"
require "mailer/logger_delivery"
require "mail"

RSpec.describe Palaver::Mailer::LoggerDelivery do
  subject(:delivery) { described_class.new(logger:, severity:) }

  let(:logger) { instance_spy(Logger) }
  let(:severity) { :info }
  let(:html_body_content) { "<h1>Hello</h1>" }

  let(:message) do
    body = html_body_content
    Mail.new(
      from: "sender@example.com",
      to: "recipient@example.com",
      subject: "Test Subject"
    ).tap do |m|
      # Hanami mailer adds html_body / text_body to Mail::Message
      m.define_singleton_method(:html_body) { body }
    end
  end

  describe "#call" do
    it "logs a formatted message at the given severity" do
      delivery.call(message)
      expect(logger).to have_received(:info).with(
        "FROM: sender@example.com\n" \
        "TO: recipient@example.com\n" \
        "SUBJECT: Test Subject\n" \
        "\n" \
        "#{html_body_content}"
      )
    end

    it "handles optional fields and custom severity" do
      msg = Mail.new(
        from: "a@b.com",
        to: %w[c@b.com d@b.com],
        cc: ["e@b.com"],
        bcc: ["f@b.com"],
        subject: "Sub"
      ).tap { |m| m.define_singleton_method(:html_body) { "body" } }

      delivery = described_class.new(logger:, severity: :warn)
      delivery.call(msg)

      expect(logger).to have_received(:warn).with(
        "FROM: a@b.com\n" \
        "TO: c@b.com, d@b.com\n" \
        "CC: [\"e@b.com\"]\n" \
        "BCC: [\"f@b.com\"]\n" \
        "SUBJECT: Sub\n" \
        "\n" \
        "body"
      )
    end
  end
end
