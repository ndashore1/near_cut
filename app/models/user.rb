# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  include PasswordValidator

  validates :name, presence: true
  validate :valid_password?
end
