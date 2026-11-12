# frozen_string_literal: true

class Discussion::Actions::Category::Show < Discussion::Action
  include Discussion::Deps[
    slugger: "utils.slugger"
  ]

  def handle(req, res)
    res[:id] = slugger.decode_id(req.params[:id])
  end
end
