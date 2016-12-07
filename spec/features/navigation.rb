
require 'rails_helper'

RSpec.feature "navigation" do

  it "should navigate to about page from home page" do
    visit root_path
    click_on "about"
    expect(page).to have_current_path about_path
  end

  it "should navigate to home page from about page" do
    visit about_path
    click_on "logo"
    expect(page).to have_current_path root_path
  end

  it 'should navigate to new user page from home' do
    visit root_path
    click_on "sign_up"
    expect(page).to have_current_path new_user_path
  end

  it 'should navigate to users page from home' do
    visit root_path
    click_on "users"
    expect(page).to have_current_path users_path
  end

  it 'should navigate to user page from user index' do
    user = User.create(name: 'sven', email: 'sven@example.com', password: 'secret123', password_confirmation: 'secret123')
    visit users_path
    click_link "#{user.name}"
    expect(page).to have_current_path user_path(user)
  end

  it 'should navigate to log in page' do
    visit root_path
    click_link "log_in"
    expect(page).to have_current_path login_path
  end
  
  it 'should not see account secion in the header if the user is not logged in' do
    visit root_path
    expect(page).to_not have_content('Account')
  end

  it 'should navigate to user edit page from root path for logged in and activated user' do
    @user = User.create(name: 'user', email: 'user@example.com', password: 'secret123', password_confirmation: 'secret123')
    @user.toggle!(:activated)
    visit login_path
    fill_in('Email', :with => @user.email)
    fill_in('Password', :with => @user.password)
    click_on 'log_in_submit_form'
    expect(page).to have_current_path user_path(@user)
    click_on 'Settings'
    expect(page).to have_current_path edit_user_path(@user)
  end
  
  it 'should not log in unactivated user' do  
    @user = User.create(name: 'user', email: 'user@example.com', password: 'secret123', password_confirmation: 'secret123')
    visit login_path
    fill_in('Email', :with => @user.email)
    fill_in('Password', :with => @user.password)
    click_on 'log_in_submit_form'
    expect(page).to have_current_path root_path
    expect(page).to have_content("Account not activated.")
  end

  it 'should not allow to view followers and following unless user is logged in' do
    @user = User.create(name: 'user', email: 'user@example.com', password: 'secret123', password_confirmation: 'secret123')
    @user.toggle!(:activated)
    @another_user = User.create(name: 'another_user', email: 'another_user@example.com', password: 'secret123', password_confirmation: 'secret123')
    visit followers_user_path(@user)
    expect(page).to have_current_path login_path
    fill_in('Email', :with => @user.email)
    fill_in('Password', :with => @user.password)
    click_on 'log_in_submit_form'
    expect(page).to have_current_path followers_user_path(@user)
  end

end
