module Charts
  class FacebookChart < Base
    def background_color
      'rgba(59, 89, 152, .4)'
    end

    def label
      :facebook
    end

    def relation
      FacebookPost
    end
  end
end
