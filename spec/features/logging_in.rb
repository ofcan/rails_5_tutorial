
require 'rails_helper'

RSpec.feature "navigation" do

  background do
    @user = User.create(name: 'user', email: 'user@example.com', password: 'secret123', password_confirmation: 'secret123')
  end

  it "should log the user in" do
    visit login_path
    fill_in('Email', :with => 'user@example.com')
    fill_in('Password', :with => 'secret123')
    click_on 'log_in'
    expect(page).to have_current_path user_path(@user)
  end

end
