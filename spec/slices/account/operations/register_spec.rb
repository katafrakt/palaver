RSpec.describe Account::Operations::Register do
  let(:repo) { double(:repo) }
  subject(:operation) { described_class.new }
  let(:non_unique_exception) do
    ROM::SQL::UniqueConstraintError.new(StandardError.new)
  end

  stub(Account::Container, "repositories.account") { repo }

  it "calls the repository's create" do
    account = double(:account)
    expect(repo).to receive(:create) { account }

    result = operation.call(email: "test@test.com", password: "123456")
    expect(result).to be_success
  end

  it "handles non-unique email" do
    allow(repo).to receive(:create).and_raise(non_unique_exception)

    result = operation.call(email: "test@test.com", password: "123456")
    expect(result).to be_failure
    expect(result.failure).to eq(:email_not_unique)
  end
end
