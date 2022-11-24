RSpec.describe "GET /cat/:id", type: :request do
  specify "with no threads" do
    category = Discussion::Repositories::Categories.new.create(name: "abcd")
    get "/cat/#{category.id}"

    expect(last_response).to be_successful
    expect(last_response.body).to include("No threads")
  end
end
