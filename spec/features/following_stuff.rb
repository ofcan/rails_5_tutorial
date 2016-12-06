
require 'rails_helper'

RSpec.feature "navigation" do

  background do
    @user_a = User.create(name: 'user_a', email: 'user_a@example.com', password: 'secret123', password_confirmation: 'secret123')
    @user_b = User.create(name: 'user_b', email: 'user_b@example.com', password: 'secret123', password_confirmation: 'secret123')
  end
  
  it "should follow and unfollow a user properly" do
    expect(@user_a.following?(@user_b)).to be false
    @user_a.follow(@user_b)
    expect(@user_a.following?(@user_b)).to be true
    @user_a.unfollow(@user_b)
    expect(@user_a.following?(@user_b)).to be false
  end

  it "should return all the users following a user" do
    @user_a.follow(@user_b)
    expect(@user_b.followed_by?(@user_a)).to be true
  end

end
