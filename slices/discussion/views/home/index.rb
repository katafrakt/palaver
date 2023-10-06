# frozen_string_literal: true

class Discussion::Views::Home::Index < Palaver::View
  def template
    div do
      render Discussion::Views::Shared::Components::NoProfileWarning.new(current_user)
      render Discussion::Views::Home::Components::Tabs.new(:categories)

      div(class: "section") do
        @categories.each do |category|
          render Discussion::Views::Home::Partials::Category.new(category: category)
        end
      end
    end
  end
end
