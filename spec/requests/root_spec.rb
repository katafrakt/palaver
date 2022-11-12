# frozen_string_literal: true

RSpec.describe "Root", type: :request do
  let(:container) { Discussion::Container }
  let(:category) {
    category = Factory.structs[:category]
    def category.thread_count = 0
    def category.message_count = 0
    latest_thread = category.latest_thread
    def latest_thread.last_message = Factory.structs[:last_message]
    category
  }

  it "is succesful" do
    repo = double("fake repo", homepage: [category])
    container.stub("repositories.categories", repo)

    get "/"

    expect(last_response).to be_successful
    expect(last_response.body).to include("Categories")
    expect(last_response.body).to include(category.name)
  end
end
