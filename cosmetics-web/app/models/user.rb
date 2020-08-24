class User < ApplicationRecord
  NEW_EMAIL_TOKEN_VALID_FOR = 600 # 10 minutes

  include NewEmailConcern

  attribute :old_password, :string

  validates :new_email, :email => {:allow_nil => true}

  def send_new_email_confirmation_email
    NotifyMailer.new_email_verification_email(self).deliver_later
  end
end
