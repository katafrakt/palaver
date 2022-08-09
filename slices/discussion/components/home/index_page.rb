class Discussion::Components::Home::IndexPage < Phlex::Component
  def initialize(target:)
    @target = target
  end

  def template
    p "Hello #{@target}!"
  end
end