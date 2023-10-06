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
end
