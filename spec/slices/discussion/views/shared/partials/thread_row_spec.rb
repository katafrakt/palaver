require "nokolexbor"

RSpec.describe Discussion::Views::Shared::Partials::ThreadRow do
  include Phlex::Testing::ViewHelper

  let(:thread) { Discussion::Entities::Thread.new(title: "Registrations are now closed", id: 22, message_count: 1, pinned: false, messages: []) }

  it "contains a link to a category" do
    row = described_class.new(thread)
    doc = Nokolexbor::HTML(render(row))
    thread_link = doc.xpath("//a").detect { |link| link.attributes["href"].to_s.include?(thread_slug(thread)) }
    expect(thread_link.attributes["href"].to_s).to eq("/th/registrations-are-now-closed-BNtg")
  end
end
