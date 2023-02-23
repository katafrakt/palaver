RSpec.describe Palaver::Entity do
  it "returns attribute" do
    entity = Palaver::Entity.new(test: "test")
    expect(entity.test).to eq("test")
  end

  it "raises NoMethodError when asking for a non-attribute" do
    entity = Palaver::Entity.new(test: "test")
    expect { entity.name }.to raise_error(NoMethodError)
  end

  it "supports respond_to?" do
    entity = Palaver::Entity.new(test: "test")
    expect(entity.respond_to?(:test)).to eq(true)
    expect(entity.respond_to?(:restart)).to eq(false)
  end
end
