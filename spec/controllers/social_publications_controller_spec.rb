require 'rails_helper'

RSpec.describe SocialPublicationsController, type: :controller do
  describe '#create' do
    let(:user)        { create :user }
    let(:day_subject) { create :day_subject }

    before { sign_in user }

    subject { post :create, params }

    context 'validations' do
      let(:params) { { social_post: { day_subject_id: day_subject.to_param, service_name: service_name, message: 'Hello' }, format: :js } }

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

    # TODO: Finish it
    context 'when successfully created social post', pending: true do
      let(:day_subject_image) { create :day_subject_image, day_subject: day_subject }
      let!(:social_profile)   { create :social_profile, :twitter, user: user }

      let(:service_name) { 'TwitterPost' }
      let(:params)       { { social_post: { day_subject_id: day_subject.to_param, day_subject_image_id: day_subject_image.to_param,
                                                                    service_name: service_name, message: 'Hello', format: :js } } }
      let(:twitter_client) { double }
      let(:twitter_post)   { TwitterPost.first }

      before do
        allow(Twitter::REST::Client).to receive(:new).and_return(twitter_client)
        allow(twitter_client).to receive(:update_with_media).and_return(::Twitter::Tweet.new({ id: 111111 }))
      end

      it 'create social post' do
        # expect { subject }.to change { TwitterPost.count }.by(1)
        # subject

        # expect(twitter_post.post_id).to eq 111111
        # expect(twitter_post.message).to eq 'Hello'
        # expect(twitter_post.day_subject).to eq day_subject
        # expect(twitter_post.day_subject_image).to eq day_subject_image
      end
    end
  end
end
