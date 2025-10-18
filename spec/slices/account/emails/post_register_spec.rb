# frozen_string_literal: true

RSpec.describe Account::Emails::PostRegister do
  let(:account) do
    double("Account",
      id: 123,
      email: "user@example.com",
      confirmation_token: "abc123token456")
  end

  let(:email) { described_class.new.build(account:) }

  it "sets recipient to account email" do
    expect(email.to).to eq(["user@example.com"])
  end

  it "sets sender to accounts email" do
    expect(email.from).to eq(["accounts@palaver.dev"])
  end

  it "sets correct subject" do
    expect(email.subject).to eq("Your account has been created")
  end

  it "includes both id and token in confirmation URL" do
    html_content = email.html_part.body.to_s
    expect(html_content).to include("http://test.localhost/account/confirm?id=123&token=abc123token456")
  end
end
