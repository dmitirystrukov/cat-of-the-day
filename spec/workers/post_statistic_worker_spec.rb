require 'rails_helper'

RSpec.describe PostStatisticWorker, type: :worker do
  describe '#perform' do
    let(:user)        { create :user }
    let(:day_subject) { create :day_subject_with_image }

    let(:twitter_client) { double }
    let!(:outdated_post) { create :social_post, user: user, day_subject_id: day_subject.to_param,
                                  day_subject_image_id: day_subject.day_subject_images.first.to_param, service_name: 'TwitterPost' }

   before do
     allow(Providers::Twitter).to receive(:new).and_return(twitter_client)
     allow(twitter_client).to receive(:post_exists?).and_return(false)
   end

    subject { described_class.new.perform }

    it 'should change post state' do
      expect { subject }.to change { outdated_post.reload.status }.to 'inactive'
    end
  end
end
