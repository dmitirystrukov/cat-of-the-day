require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#provider_active_class' do
    let(:current_user)    { create :user }
    let(:provider_name)   { 'twitter' }

    before { sign_in current_user }

    subject { provider_active_class(provider_name) }

    context 'when profile with that name exists' do
      let!(:social_profile) { create :social_profile, :twitter, user: current_user }

      it 'should return active' do
        expect(subject).to eq 'active'
      end
    end

    context 'when profile with that name not exists' do
      let(:provider_name) { 'facebook' }

      it 'should return empty string' do
        expect(subject).to eq ''
      end
    end
  end

  describe '#tab_active_class' do
    let(:collection) { %w(facebook twitter) }

    subject { tab_active_class(provider_name, collection) }

    context 'when provider name first in collection' do
      let(:provider_name) { 'facebook' }

      it 'should have active class' do
        expect(subject).to eq 'active'
      end
    end

    context 'when provider name not first in collection' do
      let(:provider_name) { 'twitter' }

      it 'should have not active class' do
        expect(subject).to eq ''
      end
    end
  end

  describe '#post_statistic_fields' do
    let(:user) { create :user }
    let(:day_subject) { create :day_subject_with_image, user: user }
    let(:social_post) do
      create :social_post, user: user, day_subject: day_subject, service_name: 'FacebookPost',
                           day_subject_image_id: day_subject.day_subject_images.first.to_param
    end

    let(:result) do
      ["<i class=\"fa fa-heart\"><span>#{social_post.data.likes_count}</span></i>",
       "<i class=\"fa fa-retweet\"><span>#{social_post.data.reposts_count}</span></i>"]
    end

    subject { post_statistic_fields(social_post.data) }

    it 'should return array of social post data' do
      expect(subject).to eq result
    end
  end
end
