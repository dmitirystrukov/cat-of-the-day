module ProviderTool
  extend ActiveSupport::Concern

  included do
    PROVIDER_POST_IDS = {
      'FacebookPost' => ->(post) { post['post_id'] },
      'TwitterPost'  => ->(post) { post.id }
    }

    PROVIDER_PROFILE_DATA = {
      'FacebookPost' => ->(user) { user.facebook_post_data },
      'TwitterPost'  => ->(user) { user.twitter_post_data }
    }

    private

    def provider_collection_name
      social_post_params[:service_name].classify.constantize.model_name.plural
    end

    def get_post_id(post)
      PROVIDER_POST_IDS[provider_type].call(post)
    end

    def profile_data
      PROVIDER_PROFILE_DATA[provider_type].call(current_user)
    end

    def provider_type
      social_post_params[:service_name]
    end
  end
end
