# auto_register: false
# frozen_string_literal: true

class Discussion::Action < Palaver::Action
  before do |_, res|
    res[:current_user] = Discussion::AntiCorruptionLayer.transform_current_user(res[:current_user])
  end
end
