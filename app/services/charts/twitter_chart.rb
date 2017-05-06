module Charts
  class TwitterChart < Base
    def background_color
      'rgba(29, 161, 242, .4)'
    end

    def label
      :twitter
    end

    def relation
      TwitterPost
    end
  end
end
