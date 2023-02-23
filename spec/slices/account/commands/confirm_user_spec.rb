RSpec.describe Account::Commands::ConfirmUser do
  include Dry::Monads[:result]
  subject(:command) { described_class.new }
  let(:repo) { double(:repo) }
  stub(Account::Container, "repositories.account") { repo }

  it "returns failure when there is no user" do
    allow(repo).to receive(:by_id_and_token).and_return(nil)
    expect(command.call(123, "abc")).to eq(Failure(:user_not_found))
  end

  it "returns failure when user is already confirmed" do
    account = Fixtures::Account.current_user_entity(confirmed_at: Time.now)
    allow(repo).to receive(:by_id_and_token).and_return(account)
    expect(command.call(123, "abc")).to eq(Failure(:already_confirmed))
  end

  it "confirms user if conditions met" do
    account = Fixtures::Account.current_user_entity(confirmed_at: nil)
    allow(repo).to receive(:by_id_and_token).and_return(account)
    expect(repo).to receive(:confirm_user)
    expect(command.call(123, "abc")).to be_success
  end
end
