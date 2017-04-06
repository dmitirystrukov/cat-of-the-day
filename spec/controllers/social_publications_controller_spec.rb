require 'rails_helper'

RSpec.describe SocialPublicationsController, type: :controller do
  describe '#create' do
    let(:user)        { create :user, :with_role, user_role: :consumer }
    let(:day_subject) { create :day_subject }

    before { sign_in user }

    subject { post :create, params }

    context 'when user client' do
      let(:client) { create :user, :with_role, user_role: :client }
      let(:day_subject_image) { create :day_subject_image, day_subject: day_subject }

      let(:params) do
        { social_post: { day_subject_id: day_subject.to_param, day_subject_image_id: day_subject_image.to_param,
                         service_name: 'TwitterPost', message: 'Hello' }, format: :js }
      end

      before { sign_in client }

      before do
        allow(controller).to receive(:proccess_validation!).and_return(true)
      end

      it { expect { subject }.to raise_error CanCan::AccessDenied }
    end

    context 'validations' do
      let(:params) do
        { social_post: { day_subject_id: day_subject.to_param, service_name: service_name,
                         message: 'Hello' }, format: :js }
      end

      context 'when profile data empty' do
        let(:service_name) { 'TwitterPost' }
        let!(:social_profile) { create :social_profile, user: user }

        it 'redirect to day_subject and render flash' do
          expect(subject).to redirect_to(day_subject)
          expect(flash[:error]).to eq 'Provider validation error'
        end
      end

      context 'when provider type wrong' do
        let(:service_name) { 'WrongProvider' }
        let!(:social_profile) { create :social_profile, :twitter, user: user }

        it 'redirect to day_subject and render flash' do
          expect(subject).to redirect_to(day_subject)
          expect(flash[:error]).to eq 'Provider validation error'
        end
      end

      context 'when day subject image empty' do
        let(:service_name) { 'TwitterPost' }
        let!(:social_profile) { create :social_profile, :twitter, user: user }

        it 'redirect to day_subject and render flash' do
          expect(subject).to redirect_to(day_subject)
          expect(flash[:error]).to eq 'Provider validation error'
        end
      end
    end

    context 'when successfully created social post' do
      let(:day_subject_image) { create :day_subject_image, day_subject: day_subject }
      let(:params) do
        { social_post: { day_subject_id: day_subject.to_param, day_subject_image_id: day_subject_image.to_param,
                         service_name: service_name, message: 'Hello' }, format: :js }
      end

      context 'when twitter provider' do
        let!(:social_profile) { create :social_profile, :twitter, user: user }
        let(:service_name)    { 'TwitterPost' }

        let(:twitter_client) { double }
        let(:status)         { double }
        let(:twitter_post)   { TwitterPost.first }

        before do
          allow(Twitter::REST::Client).to receive(:new).and_return(twitter_client)
          allow(twitter_client).to receive(:update_with_media).and_return(::Twitter::Tweet.new(id: 111_111))

          allow(twitter_client).to receive(:status).and_return(status)
          allow(status).to receive(:url).and_return('someurl')
        end

        it 'create twitter post' do
          expect { subject }.to change { TwitterPost.count }.by(1)
            .and change { user.reload.twitter_posts.count }.by(1)

          expect(twitter_post.post_id).to eq '111111'
          expect(twitter_post.message).to eq 'Hello'
          expect(twitter_post.day_subject_id).to eq day_subject.id
          expect(twitter_post.day_subject_image).to eq day_subject_image
        end
      end

      context 'when facebook provider' do
        let!(:social_profile) { create :social_profile, :facebook, user: user }
        let(:service_name) { 'FacebookPost' }

        let(:facebook_client) { double }
        let(:status)          { double }
        let(:facebook_post)   { FacebookPost.first }

        before do
          allow(Koala::Facebook::API).to receive(:new).and_return(facebook_client)
          allow(facebook_client).to receive(:put_picture).and_return('post_id' => 111_111)

          allow(facebook_client).to receive(:get_object).and_return('permalink_url' => 'someurl')
        end

        it 'create facebook post' do
          expect { subject }.to change { FacebookPost.count }.by(1)
            .and change { user.reload.facebook_posts.count }.by(1)

          expect(facebook_post.post_id).to eq '111111'
          expect(facebook_post.message).to eq 'Hello'
          expect(facebook_post.day_subject_id).to eq day_subject.id
          expect(facebook_post.day_subject_image).to eq day_subject_image
        end
      end
    end
  end
end
