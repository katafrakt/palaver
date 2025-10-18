require "mail"

RSpec.describe Account::Operations::Register do
  subject(:operation) { described_class.new }

  before do
    Mail::TestMailer.deliveries.clear
  end

  it "returns success with account" do
    result = operation.call(email: "test@test.com", password: "123456")
    expect(result).to be_success
    expect(result.value!).to be_kind_of(Account::Entities::Account)
  end

  it "sends a registration email" do
    result = operation.call(email: "test@test.com", password: "123456")
    email = Mail::TestMailer.deliveries.first
    expect(email).not_to be_nil
    expect(email.subject).to eq("Your account has been created")
    expect(email.html_part.body.to_s).to match("test@test.com")
  end

  describe "with non-unique email" do
    let(:repo) { double(:repo) }
    stub(Account::Container, "repositories.account") { repo }

    before do
      exception = ROM::SQL::UniqueConstraintError.new(StandardError.new)
      allow(repo).to receive(:create).and_raise(exception)
    end

    it "returns failure" do
      result = operation.call(email: "test@test.com", password: "123456")
      expect(result).to be_failure
      expect(result.failure).to eq(:email_not_unique)
    end
  end
end
