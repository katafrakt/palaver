# frozen_string_literal: true

RSpec.describe "Root", type: :request do
  let(:container) { Discussion::Container }
  let(:category) {
    category = Factory.structs[:category]
    def category.topic_count = 0
    def category.post_count = 0
    latest_topic = category.latest_topic
    def latest_topic.last_post = Factory.structs[:last_post]
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
