# frozen_string_literal: true

class ConfirmedOrderMailer < ApplicationMailer
  def confirm_order_email(email)
    mail(to: email, body: I18n.t('checkouts.confrim_order_mailer.email'))
  end
end
