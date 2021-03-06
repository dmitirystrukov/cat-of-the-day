require 'rails_helper'

RSpec.describe Account::StatisticsController, type: :controller do
  let(:consumer) { create :user, :with_role, user_role: :consumer }
  let(:client)   { create :user, :with_role, user_role: :client }

  describe '#index' do
    subject { get :index }

    context 'user has role consumer' do
      before { sign_in consumer }

      it { expect { subject }.to raise_error CanCan::AccessDenied }
    end

    context 'user has role client' do
      let(:created_at)   { Time.new(2012, 12, 31, 12, 0, 0, '+02:00') }
      let(:user)         { create :user }
      let(:day_subject)  { create :day_subject_with_image }
      let(:chart_data)   { JSON.parse assigns(:charts_data) }

      let(:result_data) do
        {
          'labels' => ['31/12/12'],
          'datasets' =>
             [
               { 'backgroundColor' => 'rgba(59, 89, 152, .4)', 'label' => 'facebook', 'data' => [10] },
               { 'backgroundColor' => 'rgba(29, 161, 242, .4)', 'label' => 'twitter', 'data' => [5] }
             ]
        }
      end

      let(:day_subject_image_id) { day_subject.day_subject_images.first.to_param }

      let!(:twitter_posts) do
        create_list :social_post, 5, user: user, day_subject_id: day_subject.to_param, created_at: created_at,
                                     day_subject_image_id: day_subject_image_id, service_name: 'TwitterPost'
      end

      let!(:facebook_posts) do
        create_list :social_post, 10, user: user, day_subject_id: day_subject.to_param, created_at: created_at,
                                      day_subject_image_id: day_subject_image_id, service_name: 'FacebookPost'
      end

      before { sign_in client }

      it { expect { subject }.to_not raise_error CanCan::AccessDenied }

      it 'should return chart data' do
        subject

        expect(chart_data).to eq result_data
      end
    end
  end
end
