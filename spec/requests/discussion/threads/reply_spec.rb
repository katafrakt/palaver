RSpec.describe "POST /th/:id/reply", type: :request do
  let(:user) { Account::Container["repositories.account"].create(email: "test@test.com") }
  let(:author) { Factories::Discussion.profile(email: "test@test.com") }

  let(:thread) do
    category = Factories::Discussion.category
    Factories::Discussion.thread(category:, author:)
  end

  context "as a signed in user" do
    before do
      sign_in(user: user)
    end

    specify "I am redirected to the last page with anchor to my reply" do
      post "/th/#{thread_slug(thread)}/reply", reply: "This is a reply"

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to match(%r{^/th/#{thread_slug(thread)}\?page=1#message-\d+$})
    end

    specify "I am redirected to page 2 when thread has 15+ messages" do
      # Create 15 existing replies to push new reply to page 2
      15.times { |i| Factories::Discussion.message(thread: thread, author: author, content: "Reply #{i + 1}") }

      post "/th/#{thread_slug(thread)}/reply", reply: "This is a reply on page 2"

      expect(last_response.status).to eq(302)
      expect(last_response.headers["Location"]).to match(%r{^/th/#{thread_slug(thread)}\?page=2#message-\d+$})
    end

    context "for locked thread" do
      before do
        Factories::Moderation.lock_thread(thread.id)
      end

      specify "I see a flash message that the thread is locked" do
        post "/th/#{thread_slug(thread)}/reply", reply: "This is a reply"
        follow_redirect!

        expect(last_response.body).not_to include("This is a reply")
        expect(last_response.body).to include("This thread is locked")
      end
    end
  end
end
