class Account::Entities::CurrentUser < Palaver::Entity
  def signed_in? = !id.nil?

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
