class WelcomeController < ApplicationController
  def index
    @posts  = current_site.posts.published.order_by_recently
    @topics = current_site.topics if current_site.bbs_enabled?
  end
end
