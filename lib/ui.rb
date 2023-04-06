require "phlex"

module Ui
  def self.setup_loader
    Zeitwerk::Loader.new.tap do |loader|
      loader.push_dir(Hanami.app.root.join("lib", "ui"), namespace: Ui)
    end.setup
  end
end

Ui.setup_loader
