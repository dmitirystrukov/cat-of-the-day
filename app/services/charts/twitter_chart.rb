module Charts
  class TwitterChart < Base
    def dataset
      ::TwitterChart.new(label: "twitter (#{relation.count})",
                         data:  chart_data(relation, period_dates(relation))).instance_values
    end

    private

    def relation
      if user_id.present?
        TwitterPost.where(user_id: user_id)
      else
        TwitterPost
      end
    end
  end
end
