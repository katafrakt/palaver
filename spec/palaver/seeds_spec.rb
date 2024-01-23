require Hanami.app.root.join("db", "seeds")

RSpec.describe Seeds do
  it "runs the seeds" do
    Seeds.new.run
  end
end
