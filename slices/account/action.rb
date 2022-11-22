# auto_register: false
# frozen_string_literal: true

module Account
  class Action < Palaver::Action
    def render_on_invalid_params(res, template)
      req = res.request
      if !req.params.valid?
        res.status = 422
        res.body = render(template, values: req.params.to_h, errors: req.params.errors)
        halt
      end
    end
  end
end
