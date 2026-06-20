require "mail"

RSpec.describe Account::Operations::Register do
  subject(:operation) { described_class.new }
  let(:test_mailer) { Hanami.app["mailers.delivery_method"] }

  before { test_mailer.clear }

  it "returns success with account" do
    result = operation.call(email: "test@test.com", password: "123456")
    expect(result).to be_success
    expect(result.value!).to be_kind_of(Account::Entities::Account)
  end

  it "sends a registration email" do
    operation.call(email: "test@test.com", password: "123456")
    email = test_mailer.deliveries.first.message
    expect(email).not_to be_nil
    expect(email.subject).to eq("Welcome to Palaver!")
    expect(email.html_body).to match("test@test.com")
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
