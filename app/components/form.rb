# frozen_string_literal: true

class Palaver::Components::Form < Phlex::HTML
  attr_reader :url

  def initialize(url:, multipart: false)
    @url = url
    @multipart = multipart
  end

  def template(&content)
    params = {method: "POST", action: url}
    params[:enctype] = "multipart/form-data" if @multipart
    form(**params, &content)
  end
end
