require 'rails_helper'

RSpec.describe 'day_subjects/show/consumer/show.haml', type: :view do
  let(:consumer)    { create :user, :with_role, user_role: :consumer }
  let(:day_subject) { create :day_subject_with_image }

  let!(:social_post) { create :social_post, user: consumer, day_subject: day_subject, service_name: 'TwitterPost',
                                                        day_subject_image_id: day_subject.day_subject_images.first.to_param }

  before { sign_in consumer }
  before { assign(:day_subject, day_subject) }

  before do
    assign(:social_posts, { 'twitter' => [social_post] })
  end

  it 'returns twitter active tab' do
    render
    expect(rendered).to have_css('section#twitter.active')
  end
end
