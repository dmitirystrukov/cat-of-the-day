require 'rails_helper'

RSpec.describe AccountChart, type: :service do
  let(:instance) { described_class.new }

  describe '#populate' do
    let(:user) { create :user }
    let(:day_subject) { create :day_subject_with_image }

    let!(:facebook_posts) { create_list :social_post, 5, user: user, day_subject_id: day_subject.to_param, service_name: 'FacebookPost',
                                             day_subject_image_id: day_subject.day_subject_images.first.to_param, created_at: Date.new(2017, 3, 1) }
    let!(:twitter_posts)  { create_list :social_post, 5, user: user, day_subject_id: day_subject.to_param, service_name: 'TwitterPost',
                                             day_subject_image_id: day_subject.day_subject_images.first.to_param, created_at: Date.new(2017, 3, 2) }
    let(:data) { JSON.parse subject }
    let(:dataset) do
      [
        {
          'label' => 'facebook (5)',
          'data' => [5, 0],
          'backgroundColor' => 'rgba(59, 89, 152, .4)'
        },
        {
          'label' => 'twitter (5)',
          'data' => [0, 5],
          'backgroundColor' => 'rgba(29, 161, 242, .4)'
        }
      ]
    end

    subject { instance.populate }

    it 'should properly return labels and dataset' do
      expect(data['labels']).to eq ['01/03/17', '02/03/17']
      expect(data['datasets']).to eq dataset
    end
  end
end
