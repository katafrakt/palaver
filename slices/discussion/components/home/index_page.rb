class Discussion::Components::Home::IndexPage < Phlex::View
  def initialize(target:)
    @target = target
  end

  def template
    p { "Hello #{@target}!" }
  end
end