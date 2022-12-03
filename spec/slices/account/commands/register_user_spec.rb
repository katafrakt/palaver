RSpec.describe Account::Commands::RegisterUser do
  let(:repo) { double(:repo) }
  subject(:command) { described_class.new }
  let(:non_unique_exception) do
    ROM::SQL::UniqueConstraintError.new(StandardError.new)
  end

  around do |example|
    Account::Container.stub("repositories.account", repo)
    example.run
    Account::Container.unstub("repositories.account")
  end

  it "calls the repository's create" do
    account = double(:account)
    expect(repo).to receive(:create) { account }

    result = command.call("test@test.com", "123456")
    expect(result).to eq([:ok, account])
  end

  it "handles non-unique email" do
    allow(repo).to receive(:create).and_raise(non_unique_exception)

    result = command.call("test@test.com", "123456")
    expect(result).to eq([:error, :email_not_unique])
  end
end
