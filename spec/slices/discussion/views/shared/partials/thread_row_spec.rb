require "nokolexbor"

RSpec.describe Discussion::Views::Shared::Partials::ThreadRow do
  include ComponentTestingHelper

  let(:repo) { Discussion::Repositories::Thread.new }
  let(:struct) { repo.recent_threads.mapper.model }
  let(:thread) do
    struct.new(
      title: "Registrations are now closed",
      id: 22,
      message_count: 1,
      pinned: false,
      messages: [],
      category_id: 1,
      first_message_id: 1,
      last_message_id: 10,
      locked: false
    )
  end

  it "contains a link to a category" do
    row = described_class.new(thread)
    doc = Nokolexbor::HTML(render(row))
    thread_link = doc.xpath("//a").detect { |link| link.attributes["href"].to_s.include?(thread_slug(thread)) }
    expect(thread_link.attributes["href"].to_s).to eq("/th/registrations-are-now-closed-BNtg")
  end
end
