module ComponentTestingHelper
  def render(component)
    component.call
  end
end
