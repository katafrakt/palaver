# frozen_string_literal: true

class Palaver::Components::Form < Phlex::HTML
  attr_reader :url

  def initialize(url:)
    @url = url
  end

  def template(&content)
    form(method: "POST", action: url, &content)
  end
end
