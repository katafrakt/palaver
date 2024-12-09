require "nokolexbor"

RSpec.describe Discussion::Views::Home::Partials::Category do
  include Phlex::Testing::ViewHelper

  let(:category) { Discussion::Entities::Category.new(name: "Announcements", id: 24, thread_count: 25, message_count: 67) }

  it "contains a link to a category" do
    row = described_class.new(category:)
    doc = Nokolexbor::HTML(render(row))
    category_link = doc.xpath("//a").detect { |link| link.attributes["href"].to_s.include?(category_slug(category)) }
    expect(category_link.attributes["href"].to_s).to eq("/cat/announcements-0Vh4")
  end

  it "displays informatio about last message and its author" do
    author = Discussion::Entities::Author.new(nickname: "John", id: 123, account_id: 17)
    thread = Discussion::Entities::Thread.new(id: 1, title: "Welcome thread", author:)
    row = described_class.new(category: Discussion::Entities::Category.new(category.attributes.merge(latest_thread: thread)))
    doc = Nokolexbor::HTML(render(row))
    profile_link = doc.xpath("//a").detect { |link| link.attributes["href"].to_s.include?("th/") }
    expect(profile_link).to_not be_nil
  end
end
