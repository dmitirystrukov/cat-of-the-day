module Account
  class StatisticsController < ApplicationController
    authorize_resource class: false

    SHOW_LATEST = 9

    before_action :authenticate_user!

    def index
      @chart_data = AccountChart.new.populate
      @social_posts = SocialPost.includes(:day_subject_image, :user).latest(SHOW_LATEST)
    end
  end
end
