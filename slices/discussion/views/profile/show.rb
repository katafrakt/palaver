# frozen_string_literal: true

class Discussion::Views::Profile::Show < Palaver::View
  include Ui::Typography

  def template
    div do
      heading2(@profile.nickname)
    end
  end
end
