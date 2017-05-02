class ChartsFetcher
  DATE_FORMAT = '%d/%m/%y'.freeze

  attr_reader :user_id, :relation, :chart_types

  def initialize(chart_types, user_id=nil)
    @user_id = user_id
    @chart_types = chart_types

    @relation =
      case
      when user_id.present?
        SocialPost.where(user_id: user_id)
      else
        SocialPost
      end
  end

  def collect
    {
      labels:   labels(period_dates(relation)),
      datasets: datasets
    }.to_json
  end

  private

  def datasets
    chart_types.map do |chart_type_klass|
      chart = chart_type_klass.new
      chart.data = chart_data(chart_relation_by_user(chart), period_dates(relation))

      chart.instance_values.transform_keys do |key|
        key.to_s.camelize(:lower)
      end
    end
  end

  def period_dates(collection)
    collection.pluck(:created_at).uniq.map do |created_at|
      Date.strptime(created_at.strftime(DATE_FORMAT), DATE_FORMAT)
    end
  end

  def chart_relation_by_user(chart)
    user_id.present? ? chart.relation.where(user_id: user_id) : chart.relation
  end

  def chart_data(relation, dates)
    dates.map { |date| relation.where(created_at: date.midnight..date.end_of_day).count }
  end

  def labels(dates)
    dates.map { |date| date.strftime(DATE_FORMAT) }
  end
end
