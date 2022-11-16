# frozen_string_literal: true

class Palaver::Components::Typography::Heading < Phlex::HTML
  def initialize(text:, level: 1)
    @level = level
    @text = text
  end

  def template
    hd(@level, @text)
  end

  private

  def hd(level, text)
    case level
    when 1
      h1(class: "is-size-1") { text }
    when 2
      h2(class: "is-size-2 pb-3 mb-3") { text }
    else
      h3(class: "is-size-3") { text }
    end
  end
end
