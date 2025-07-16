class Account::Views::Registration::AfterCreate < Palaver::View
  include Ui::Typography

  def view_template
    div do
      heading2("Thank you for registering on Palaver")

      p do
        plain "Your account has been created. Check you email for the confirmation link."
      end
    end
  end
end
