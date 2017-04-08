module Charts
  class FacebookChart < Base
    def dataset
      ::FacebookChart.new(label: "facebook (#{relation.count})",
                          data:  chart_data(relation, period_dates)).instance_values
    end

    private

    def relation
      if user_id.present?
        FacebookPost.where(user_id: user_id)
      else
        FacebookPost
      end
    end
  end
end
