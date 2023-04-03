# frozen_string_literal: true

Hanami.app.register_provider :views do
  prepare do
    require "phlex"
    require "ui"
  end

  start do
    Zeitwerk::Loader.new.tap do |loader|
      loader.push_dir(Hanami.app.root.join("lib", "ui"), namespace: Ui)
    end.setup
  end
end
