# frozen_string_literal: true

class AdminUser < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true
  validates :reset_password_token, uniqueness: true
end
