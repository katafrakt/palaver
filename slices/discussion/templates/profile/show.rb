# frozen_string_literal: true

class Discussion::Templates::Profile::Show < Palaver::View
  include Ui::Typography

  def template
    div do
      heading2(@profile.nickname)
    end
  end
end
