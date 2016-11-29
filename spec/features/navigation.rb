
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
    expect(page).to have_current_path sessions_new_path
  end

end
