# frozen_string_literal: true

# The CurrentUser entity represents an actor interacting with the forum in the
# context of the discussion. It is amalgamation of data from account and a profile,
# as well as some data related to access limitations.
class Discussion::Entities::CurrentUser < Palaver::Entity
  include Palaver::AvatarUploader::Attachment(:avatar)

  def profile_set_up? = !attributes[:profile_id].nil?

  def signed_in? = !attributes[:id].nil?

  # access control
  def subject_id = "user:#{id}"

  def subject_type = :user

  def subject_sids
    [].tap do |sids|
      sids << :authenticated if signed_in?
    end
  end

  private

  def default_attrs = {id: nil}
end
