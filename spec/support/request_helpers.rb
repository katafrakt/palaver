# frozen_string_literal: true

module RequestHelpers
  # Helper method for signing in users in request specs
  #
  # @param [Integer] id The user ID to sign in with
  # @param [Object] user The user object to sign in with (will use user.id)
  #
  # @example Sign in with user object
  #   sign_in(user: user)
  #
  # @example Sign in with user ID
  #   sign_in(id: 123)
  #
  # @raise [ArgumentError] if both or neither parameters are provided
  def sign_in(id: nil, user: nil)
    raise ArgumentError, "Must provide exactly one of :id or :user" if [id, user].count(&:nil?) != 1

    user_id = id || user.id
    env "rack.session", {usi: user_id}
  end
end
