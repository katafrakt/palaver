# frozen_string_literal: true

class Discussion::Views::Home::Recent < Palaver::View
  def view_template
    div do
      render Discussion::Views::Shared::Components::NoProfileWarning.new(current_user)
      render Discussion::Views::Home::Components::Tabs.new(:recent)

      div(class: "section") do
        @threads.each do |thread|
          render Discussion::Views::Shared::Partials::ThreadRow.new(thread)
        end
      end
    end
  end
end
