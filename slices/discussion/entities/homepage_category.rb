# frozen_string_literal: true

class Discussion::Entities::HomepageCategory
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def method_missing(name)
    attributes[name]
  end
end
