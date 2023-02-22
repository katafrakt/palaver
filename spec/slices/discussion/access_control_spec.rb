RSpec.describe Discussion::AccessControl do
  subject(:acl) { Discussion::Container["access_control"].authorizer }
  let(:thread_model) { Discussion::Container["repositories.thread"].threads.mapper.model }

  it "disallows anonymous user to reply" do
    current_user = Account::Entities::AnonymousUser.new
    thread = thread_model.new(id: 15, category_id: 15, title: "test thread", first_message_id: 1, last_message_id: 1)
    expect(acl.authorized?(current_user, thread, :reply)).to eq(false)
  end

  it "allows authorized user to reply" do
    current_user = Account::Entities::CurrentUser.new(email: "test@test.com")
    thread = thread_model.new(id: 15, category_id: 15, title: "test thread", first_message_id: 1, last_message_id: 1)
    expect(acl.authorized?(current_user, thread, :reply)).to eq(true)
  end
end
