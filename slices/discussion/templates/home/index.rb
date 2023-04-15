# frozen_string_literal: true

class Discussion::Templates::Home::Index < Palaver::View
  def template
    div do
      render Discussion::Components::NoProfileWarning.new(current_user)
      render Discussion::Components::HomeTabs.new(:categories)

      div(class: "section") do
        @categories.each do |category|
          render Discussion::Components::CategoryRow.new(category: category)
        end
      end
    end
  end
end
