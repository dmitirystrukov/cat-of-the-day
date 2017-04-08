class Chart
  include ActiveModel::Model

  attr_accessor :background_color, :label, :data

  def initialize(attributes = {})
    super
    @background_color = background_color
  end
end
