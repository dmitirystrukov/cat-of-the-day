require 'rails_helper'

RSpec.describe DaySubject, type: :model do
  describe '#connected_provider_names' do
    let(:day_subject) { create :day_subject_with_image }
    let(:user)        { create :user }
    
    let!(:social_post) do
      create :social_post, user: user, day_subject_id: day_subject.to_param,
                           day_subject_image_id: day_subject.day_subject_images.first.to_param, service_name: 'TwitterPost'
    end

    it 'should return array of providers' do
      expect(day_subject.connected_provider_names).to eq ['twitter']
    end
  end
end
