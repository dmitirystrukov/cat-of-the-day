require 'rails_helper'

RSpec.describe SocialProvider, type: :service do
  describe '#client' do
    let(:data) { social_profile.data }
    let(:instance) { described_class.new(data, provider_type) }

    subject { instance.client }

    context 'when facebook provider' do
      let(:social_profile) { build :social_profile, :facebook }
      let(:provider_type)  { 'FacebookPost' }

      it 'proccessing via facebook provider' do
        expect(subject.class).to eq Providers::Facebook
        expect(subject.instance_variable_get(:@client).access_token).to eq 'sometoken'
      end
    end

    context 'when facebook provider' do
      let(:social_profile) { build :social_profile, :twitter }
      let(:client)         { subject.instance_variable_get(:@client) }
      let(:provider_type)  { 'TwitterPost' }

      it 'proccessing via twitter provider' do
        expect(subject.class).to eq Providers::Twitter

        expect(client.access_token).to eq 'someacesstoken'
        expect(client.access_token_secret).to eq 'sometoken'
        expect(client.consumer_key).to eq 'somekey'
        expect(client.consumer_secret).to eq 'somesecret'
      end
    end
  end

  describe '.collect_social_posts' do
    let(:day_subject)       { create :day_subject }
    let(:day_subject_image) { create :day_subject_image, day_subject: day_subject }
    let!(:social_profile)   { create :social_profile, :twitter, user_id: user_id, service_name: :twitter }

    let(:inactive_social_post) do
      create :social_post, user_id: user_id, day_subject_id: day_subject.to_param, status: :inactive,
                           service_name: 'TwitterPost', day_subject_image_id: day_subject_image.to_param
    end

    let(:facebook_social_post) do
      create :social_post, user_id: user_id, day_subject_id: day_subject.to_param, status: :active,
                           service_name: 'FacebookPost', day_subject_image_id: day_subject_image.to_param
    end

    let!(:social_posts) do
      create_list :social_post, 5, user_id: user_id, day_subject_id: day_subject.to_param,
                                   service_name: 'TwitterPost', day_subject_image_id: day_subject_image.to_param
    end

    context 'when consumer social posts' do
      let(:user)    { create :user }
      let(:user_id) { user.to_param }

      subject { described_class.collect_social_posts(user, day_subject.to_param) }

      it 'should include only active twitter posts' do
        expect(subject['twitter']).to eq TwitterPost.active
        expect(subject['twitter']).to_not include(inactive_social_post)
        expect(subject['twitter']).to_not include(facebook_social_post)
      end
    end

    context 'when client social posts' do
      let(:user_id) { Faker::Number.number(6) }

      subject { described_class.collect_social_posts(day_subject) }

      it 'should include only active twitter posts' do
        expect(subject['twitter']).to eq TwitterPost.active
        expect(subject['twitter']).to_not include(inactive_social_post)
        expect(subject['twitter']).to_not include(facebook_social_post)
      end
    end
  end
end
