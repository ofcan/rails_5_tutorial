
require 'rails_helper'

RSpec.feature "navigation" do

  it "should navigate to about page from home page" do
    visit root_path
    click_on "engage!"
    expect(page).to have_current_path about_path
  end

  it "should navigate to home page from about page" do
    visit about_path
    click_on "logo"
    expect(page).to have_current_path root_path
  end

end
