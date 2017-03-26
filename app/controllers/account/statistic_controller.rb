class Account::StatisticController < ApplicationController
  SHOW_LATEST = 9

  before_action :authenticate_user!

  def index
    @chart_data = AccountChart.new.populate
    @social_posts = SocialPost.latest(SHOW_LATEST)
  end
end
