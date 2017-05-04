module Charts
  class Base
    include ActiveModel::Model

    attr_accessor :data
    attr_reader :background_color, :label

    def initialize(attributes={})
      super
      @background_color = background_color
      @label = label
    end

    def self.for(type, attributes)
      chart =
        case type
        when :facebook
          FacebookChart
        when :twitter
          TwitterChart
        end

      chart.new(attributes)
    end
  end
end
