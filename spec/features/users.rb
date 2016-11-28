
require 'rails_helper'

RSpec.feature "users" do

  background do
    @user = User.new(name: 'user', email: 'user@example.com', password: 'secret123', password_confirmation: 'secret123')
  end

  it 'should create a new user' do
    assert @user.valid?
  end

  it 'should not create a new user without a name' do
    @user.name = ''
    expect(@user).to_not be_valid
  end

  it 'should not create a new user without an email' do
    @user.email = ''
    expect(@user).to_not be_valid
  end
  
  it 'should not create a new user without a password' do
    user = User.new(name: 'user', email: 'user@example.com', password: '', password_confirmation: 'secret123')
    expect(user).to_not be_valid
  end
  
  it 'should not create user with wrong password_confirmation' do
    @user.password_confirmation = '123'
    expect(@user).to_not be_valid
  end
  
  it 'should accept only valid email addresses' do
    addresses = %w[bubba@lula sven@gmail..com]
    addresses.each do |address|
      @user.email = address
      expect(@user).to_not be_valid
    end
  end
  
  it 'should not create duplicate users' do
    @user.save
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    expect(duplicate_user).to_not be_valid
  end

 # it "should create a new user" do
 #   visit new_user_path
 #   fill_in "name", with: "John"
 #   fill_in "email", with: "john@example.com"
 #   click_on "Create"
 #   page.has_content?('Success!')
 # end

end
