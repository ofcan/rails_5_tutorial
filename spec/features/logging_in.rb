
require 'rails_helper'

RSpec.feature "navigation" do

  background do
    @user = User.create(name: 'user', email: 'user@example.com', password: 'secret123', password_confirmation: 'secret123')
  end

  it "should log the user in" do
    visit login_path
    fill_in('Email', :with => @user.email)
    fill_in('Password', :with => @user.password)
    click_on 'log_in_submit_form'
    expect(page).to have_current_path user_path(@user)
  end
  
  #dont know how to test this actually
  #vielleicht mit dem Devise gem werde ich es schaffen...
  it "should automatically log in newly created users" do
    visit new_user_path
    fill_in('Name', :with => 'John')
    fill_in('Email', :with => 'john@example.com')
    fill_in('Password', :with => '123456')
    fill_in('Confirmation', :with => '123456')
    click_on('Create my account')
    #expect(session[:user_id]).to_not be_nil
  end
  
  it "should log the user in" do
    visit login_path
    fill_in('Email', :with => @user.email)
    fill_in('Password', :with => @user.password)
    click_on 'log_in_submit_form'
    click_on 'log_out'
    expect(page).to have_current_path root_path
    expect(page).to have_content("You've successfully logged out.")
  end

end
