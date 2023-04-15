# frozen_string_literal: true

class Discussion::Templates::Home::Recent < Palaver::View
  def template
    div do
      render Discussion::Components::NoProfileWarning.new(current_user)
      render Discussion::Components::HomeTabs.new(:recent)

      div(class: "section") do
        @threads.each do |thread|
          render Discussion::Components::ThreadRow.new(thread)
        end
      end
    end
  end
end
