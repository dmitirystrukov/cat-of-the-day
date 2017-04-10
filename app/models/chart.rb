class Chart
  include ActiveModel::Model

  attr_accessor :backgroundColor, :label, :data

  def initialize(attributes={})
    super
    @backgroundColor = background_color
  end
end
