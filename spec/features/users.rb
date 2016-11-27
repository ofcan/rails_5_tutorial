
require 'rails_helper'

RSpec.feature "users" do

  background do
    @user = User.new(name: 'user', email: 'user@example.com')
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

 # it "should create a new user" do
 #   visit new_user_path
 #   fill_in "name", with: "John"
 #   fill_in "email", with: "john@example.com"
 #   click_on "Create"
 #   page.has_content?('Success!')
 # end

end
