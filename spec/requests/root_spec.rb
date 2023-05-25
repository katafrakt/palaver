# frozen_string_literal: true

RSpec.describe "Root", type: :request do
  let(:category) { Discussion::Entities::Category.new(id: 123, name: "Test", thread_count: 0, message_count: 0) }

  let(:repo) { double("fake repo") }
  stub(Discussion::Container, "repositories.category") { repo }

  it "is succesful" do
    expect(repo).to receive(:all_with_last_thread) { [category] }

    get "/"

    expect(last_response).to be_successful
    expect(last_response.body).to include("Categories")
    expect(last_response.body).to include(category.name)
  end
end
