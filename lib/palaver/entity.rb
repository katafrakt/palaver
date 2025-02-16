class Palaver::Entity
  attr_reader :attributes

  def initialize(attributes = {})
    @attributes = default_attrs.merge(attributes)
  end

  def method_missing(name)
    attributes.key?(name) ? attributes[name] : super
  end

  def respond_to_missing?(name, _)
    attributes.key?(name)
  end

  private

  def default_attrs = {}
end
