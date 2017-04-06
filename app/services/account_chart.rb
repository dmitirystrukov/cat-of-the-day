class AccountChart
  DATE_FORMAT = '%d/%m/%y'

  attr_reader :chart_type, :user_id

  def initialize(chart_type, user_id)
    @user_id = user_id
    @chart_type = chart_type
  end

  def populate
    {
      labels: '',
      datasets:
        [
          FacebookChart.new(label: '', data: ''),
          TwitterChart.new(label: '',  data: '')
        ]
    }
  end


  # def populate
  #   {
  #     labels: labels,
  #     datasets: [
  #       {
  #         label: "facebook (#{FacebookPost.count})",
  #         data: data(FacebookPost),
  #         backgroundColor: 'rgba(59, 89, 152, .4)'
  #       },
  #       {
  #         label: "twitter (#{TwitterPost.count})",
  #         data: data(TwitterPost),
  #         backgroundColor: 'rgba(29, 161, 242, .4)'
  #       }
  #     ]
  #   }.to_json
  # end

  private

  def period_dates(relation = SocialPost)
    relation.pluck(:created_at).uniq.map do |created_at|
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

class Chart
  include ActiveModel::Model

  attr_accessor :background_color, :label, :data

  def initialize(attributes = {})
    super

    @background_color = background_color
  end
end

class FacebookChart < Chart
  def background_color
    'rgba(59, 89, 152, .4)'
  end
end

class TwitterChart < Chart
  def background_color
    'rgba(29, 161, 242, .4)'
  end
end
