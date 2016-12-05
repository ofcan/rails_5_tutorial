class StaticPagesController < ApplicationController
    
  def home
    @title = "Home"
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about
    @title = "About"
  end
  
end
