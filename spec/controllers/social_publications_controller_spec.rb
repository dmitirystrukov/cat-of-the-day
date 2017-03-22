require 'rails_helper'

RSpec.describe SocialPublicationsController, type: :controller do
  # TODO: Finish this
  describe '#create', pending: true do
    let(:user)        { create :user }
    let(:day_subject) { create :day_subject }
    let(:params)      { { social_post: { day_subject_id: day_subject.to_param, service_name: service_name, message: 'Hello' } } }

    before { sign_in user }

    subject { post :create }

    context 'when profile data empty' do
      let(:service_name) { 'TwitterPost' }
      let(:social_profile) { create :social_profile, user: user }

      specify do
        subject
      end
    end

    context 'when day subject image empty' do
    end

    context 'when provider type wrong' do
    end
  end
end
