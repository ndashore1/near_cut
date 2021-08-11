# frozen_string_literal: true

# PasswordValidator Class
module PasswordValidator
  LENGTH_REGX    = /^[\p{Z}\s]*(?:[^\p{Z}\s][\p{Z}\s]*){10,16}$/
  REAPITING_REGX = /([\s\S])\1\1/
  LOWERCASE_REGX = /\p{Lower}/
  UPPERCASE_REGX = /\p{Upper}/
  LOWER_LENGTH   = 10
  UPPER_LENGTH   = 16

  def valid_password?
    return true if errors.present?
    return errors.add :base, "#{name}'s Password can't be blank" if password.blank?
    return password_contains_number if password.count('0-9').zero?

    regex_validator
  end

  private

  def regex_validator
    return password_length if password !~ LENGTH_REGX
    return password_repeating_character if password =~ REAPITING_REGX
    return password_lower_case if password !~ LOWERCASE_REGX
    return password_uppercase if password !~ UPPERCASE_REGX

    true
  end

  def password_length
    msg = "#{name}'s Password is too "
    if password.size < LOWER_LENGTH
      msg += "short (minimum is #{LOWER_LENGTH} characters), need to add #{LOWER_LENGTH - password.size} characters"
    elsif password.size > UPPER_LENGTH
      msg += "long (maximum is #{UPPER_LENGTH} characters), need to remove #{password.size - UPPER_LENGTH} characters"
    end
    errors.add :base, msg
  end

  def password_repeating_character
    count = password.scan(REAPITING_REGX).flatten.count
    errors.add :base, "Change #{count} character of #{name}'s password"
  end

  def password_contains_number
    errors.add :base, "#{name}'s Password must contain at least 1 digit"
  end

  def password_lower_case
    errors.add :base, "#{name}'s Password must contain at least 1 lowercase"
  end

  def password_uppercase
    errors.add :base, "#{name}'s Password must contain at least 1 uppercase"
  end
end
