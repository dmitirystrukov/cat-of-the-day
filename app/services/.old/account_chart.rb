class AccountChart
  DATE_FORMAT = '%d/%m/%y'

  def populate
    {
      labels: labels,
      datasets: [
        {
          label: "facebook (#{FacebookPost.count})",
          data: data(FacebookPost),
          backgroundColor: 'rgba(59, 89, 152, .4)'
        },
        {
          label: "twitter (#{TwitterPost.count})",
          data: data(TwitterPost),
          backgroundColor: 'rgba(29, 161, 242, .4)'
        }
      ]
    }.to_json
  end

  private

  def post_dates
    SocialPost.pluck(:created_at).map do |created_at|
      Date.strptime(created_at.strftime(DATE_FORMAT), DATE_FORMAT)
    end.uniq
  end

  def data(post_type)
    post_dates.map { |date| post_type.where(created_at: date.midnight..date.end_of_day).count }
  end

  def labels
    post_dates.map { |date| date.strftime(DATE_FORMAT) }
  end
end
