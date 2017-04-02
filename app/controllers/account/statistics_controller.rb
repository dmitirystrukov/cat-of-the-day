module Account
  class StatisticsController < ApplicationController
    authorize_resource class: false

    SHOW_LATEST = 9

    before_action :authenticate_user!

    def index
      @chart_data = AccountChart.new.populate
      @social_posts = SocialPost.latest(SHOW_LATEST)
    end
  end
end
