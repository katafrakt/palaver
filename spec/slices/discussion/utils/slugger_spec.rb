RSpec.describe Discussion::Utils::Slugger do
  subject(:slugger) { described_class.new }

  it "decodes the id in slug to the same id" do
    id = rand(15_000)
    slug = slugger.to_slug(5, "abc", id)
    decoded_id = slugger.decode_id(slug)
    expect(decoded_id).to eq(id)
  end

  it "contains downcased name in the slug" do
    slug = slugger.to_slug(5, "The Big THING", 42)
    expect(slug).to include("the-big-thing")
  end
end
