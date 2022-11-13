RSpec.describe Account::Commands::RegisterUser do
  subject(:command) { described_class.new }
  let(:non_unique_exception) do
    ROM::SQL::UniqueConstraintError.new(StandardError.new)
  end

  after do
    Account::Container.unstub("repositories.account")
  end

  it "calls the repository's create" do
    repo = double(:repo)
    account = double(:account)
    expect(repo).to receive(:create) { account }
    Account::Container.stub("repositories.account", repo)

    result = command.call("test@test.com", "123456")
    expect(result).to eq([:ok, account])
  end

  it "returns email_not_unique error when creating fails" do
    repo = double(:repo)
    expect(repo).to receive(:create).and_raise(non_unique_exception)
    Account::Container.stub("repositories.account", repo)

    result = command.call("test@test.com", "123456")
    expect(result).to eq([:error, :email_not_unique])
  end
end
