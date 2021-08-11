require 'rails_helper'
Rails.application.load_tasks

describe 'validate_password', type: :task do
  it 'is valid with valid attributes' do
    user = User.new(name: 'Muhammad', password: 'QPFJWz1343439')
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil, password: 'QPFJWz1343439')
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user = User.new(name: 'Muhammad', password: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with less than 10 character password' do
    user = User.new(name: 'Muhammad', password: 'QPFJWz13')
    expect(user).to_not be_valid
  end

  it 'is not valid with more than 16 character password' do
    user = User.new(name: 'Muhammad', password: 'QPFJWz13434393ff5')
    expect(user).to_not be_valid
  end

  it 'is not valid without lowercase character in password' do
    user = User.new(name: 'Muhammad', password: 'QPFJWZ1343439')
    expect(user).to_not be_valid
  end

  it 'is not valid without upercase character in password' do
    user = User.new(name: 'Muhammad', password: 'qpfjwz1343439')
    expect(user).to_not be_valid
  end

  it 'is not valid without digit in password' do
    user = User.new(name: 'Muhammad', password: 'QPFJWzasdasd')
    expect(user).to_not be_valid
  end

  it 'is not valid with repeated chars in password' do
    user = User.new(name: 'Muhammad', password: 'QPFFFJWzasdasd')
    expect(user).to_not be_valid
  end
end
