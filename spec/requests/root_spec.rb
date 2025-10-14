# frozen_string_literal: true

RSpec.describe "Root", type: :request do
  let(:repo) { Discussion::Container["repositories.category"] }

  specify "I can see the categories" do
    category = repo.create(name: "Test")
    get "/"

    expect(last_response).to be_successful
    expect(last_response.body).to include("Categories")
    expect(last_response.body).to include(category.name)
  end
end
