module Ui
  module Typography
    def heading1(text, opts = {})
      h1(class: "is-size-1") { text }
    end

    def heading2(text)
      h2(class: "is-size-2 pb-3 mb-3") { text }
    end
  end
end
