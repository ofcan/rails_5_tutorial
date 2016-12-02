
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
  
  it 'shouldnt create a new user without password_confirmation' do
    before_count = User.count
    visit new_user_path
    fill_in('Name', :with => 'John')
    fill_in('Email', :with => 'john@example.com')
    fill_in('Password', :with => '123456')
    fill_in('Confirmation', :with => '')
    click_on('Create my account')
    expect(page).to have_content("Password confirmation doesn't match")
    after_count = User.count
    expect(before_count).to eq(after_count)
    #assert_template 'users/new'    
    #expect(current_path).to eq new_user_path
  end
  
  it 'should create a new user' do
    before_count = User.count
    visit new_user_path
    fill_in('Name', :with => 'John')
    fill_in('Email', :with => 'john@example.com')
    fill_in('Password', :with => '123456')
    fill_in('Confirmation', :with => '123456')
    click_on('Create my account')
    after_count = User.count
    expect(before_count).to_not eq(after_count)   
    #expect(current_path).to eq user_path(User.last)
    #expect(page).to have_content("Welcome #{User.last.name}!")
    expect(current_path).to eq root_path
    expect(page).to have_content("Please check your email to activate your account.")
  end
  
  it 'should visit a user page' do
    @user.save
    visit(user_path(@user))    
  end
  
  it 'should not enable not logged users to edit other users path' do
    @user.save
    visit edit_user_path @user
    expect(current_path).to eq login_path
  end

  it 'should not enable logging in unless user is activated' do
    @user.save
    login_as_user(@user)
    expect(current_path).to eq root_path
    expect(page).to have_content("Account not activated.")
  end
  
  it 'should enable logged in and activated user to edit himself' do
    @user.save
    @user.toggle!(:activated)
    login_as_user(@user)
    visit edit_user_path @user
    expect(current_path).to eq edit_user_path @user
  end
  
  it 'should not enable logged in user to edit another user' do
    @user.save
    @user.toggle!(:activated)
    @another_user = User.create(name: 'another_user', email: 'another_user@example.com', password: 'secret123', password_confirmation: 'secret123')
    login_as_user(@user)
    visit edit_user_path @another_user
    expect(current_path).to eq root_path
  end

  it "should delete a user as an admin" do
    @user.save
    @user.toggle!(:admin)
    @user.toggle!(:activated)
    @another_user = User.create(name: 'another_user', email: 'another_user@example.com', password: 'secret123', password_confirmation: 'secret123')
    login_as_user(@user)
    visit users_path
    click_link "delete_user_#{@another_user.id}"
    expect(page).to have_content('User successfuly deleted.')
  end

  it "should not be able to delete another user if current_user is not admin" do
    @user.save
    @another_user = User.create(name: 'another_user', email: 'another_user@example.com', password: 'secret123', password_confirmation: 'secret123')
    login_as_user(@user)
    visit users_path
    expect(page).to_not have_content("delete_user_#{@another_user.id}")
  end
  
  private
    
  # Log in as a particular user.
  def login_as_user(user)
    visit login_path
    fill_in('Email', :with => user.email)
    fill_in('Password', :with => user.password)
    click_on 'log_in_submit_form'
  end

end
