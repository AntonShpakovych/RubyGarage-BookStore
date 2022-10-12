# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Rails.env.test? ? Constants::Shared::TEST_EMAIL : ENV.fetch('MAIL_HOST')
  layout 'mailer'
end
