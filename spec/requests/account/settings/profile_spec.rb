require "nokolexbor"

RSpec.describe "GET /account/settings/profile", type: :request do
  it "renders avatar input" do
    user = Account::Container["repositories.account"].create(email: "test@test.com")
    Fixtures::Discussion.profile(account_id: user.id)

    env "rack.session", {usi: user.id}
    get "/account/settings/profile"
    expect(last_response.status).to eq(200)

    doc = Nokolexbor::HTML(last_response.body)
    avatar_input = doc.xpath("//input[@name='avatar']").first
    expect(avatar_input).not_to be_nil
  end
end
