module Charts
  class Base
    DATE_FORMAT = '%d/%m/%y'

    CHART_TYPES = {
      facebook_chart: FacebookChart,
      twitter_chart:  TwitterChart,
    }.freeze

    attr_reader :user_id, :relation

    def initialize(user_id = nil)
      @user_id = user_id
      @relation = user_id.present? ? SocialPost.where(user_id: user_id) : SocialPost
    end

    def populate(chart_names)
      {
        labels:   labels(period_dates(relation) ),
        datasets: datasets(chart_names)
      }.to_json
    end

    private

    def datasets(chart_names)
      chart_names.map do |chart_name|
        CHART_TYPES[chart_name].new(user_id).dataset
      end
    end

    def period_dates(collection = SocialPost)
      collection.pluck(:created_at).uniq.map do |created_at|
        Date.strptime(created_at.strftime(DATE_FORMAT), DATE_FORMAT)
      end
    end

    def chart_data(relation, dates)
      dates.map { |date| relation.where(created_at: date.midnight..date.end_of_day).count }
    end

    def labels(dates)
      dates.map { |date| date.strftime(DATE_FORMAT) }
    end
  end
end
