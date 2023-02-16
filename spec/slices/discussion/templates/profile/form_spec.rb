require "phlex/testing/view_helper"

RSpec.describe Discussion::Templates::Profile::Form do
  include Phlex::Testing::ViewHelper

  let(:context) do
    Palaver::View::Context.new(
      OpenStruct.new(session: {_csrf_token: "abc"})
    )
  end

  let(:output) do
    render described_class.new(context, profile: profile, values: {}, errors: {})
  end

  context "without existing profile" do
    let(:profile) { nil }
    it "renders correct button CTA text" do
      expect(output).to match("Set up your profile")
    end

    it "displays username field" do
      expect(output).to match('name="username"')
    end
  end

  context "with existing profile" do
    let(:profile) { Object.new }
    
    it "renders correct button CTA text" do
      expect(output).to match("Update profile")
    end

    it "does not display username field" do
      expect(output).not_to match('name="username"')
    end
  end
end