# frozen_string_literal: true

class Account::Templates::Registration::New < Phlex::View
  def template
    div do
      p { "Registration template" }
    end
  end
end
