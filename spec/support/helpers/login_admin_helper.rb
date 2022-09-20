# frozen_string_literal: true

module Helper
  module LoginAdminHelper
    def login_admin(admin)
      visit admin_root_path
      fill_in I18n.t('active_admin.devise.email.title'), with: admin.email
      fill_in I18n.t('active_admin.devise.password.title'), with: admin.password
      click_button(I18n.t('active_admin.devise.login.submit'))
    end
  end
end
