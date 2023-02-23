require "fileutils"

RSpec.configure do |config|
  uploads_dir = Hanami.app.root.join("spec", "tmp", "uploads")

  config.before :suite do
    FileUtils.mkdir_p(uploads_dir)
  end

  config.after :suite do
    FileUtils.rm_rf(uploads_dir)
  end
end
