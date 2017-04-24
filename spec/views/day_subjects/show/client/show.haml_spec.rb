require 'rails_helper'

RSpec.describe 'day_subjects/show/client/show.haml', type: :view do
  let(:client)    { create :user, :with_role, user_role: :client }
  let(:day_subject) { create :day_subject_with_image }

  let!(:social_post) { create :social_post, user: client, day_subject: day_subject, service_name: 'TwitterPost',
                                                        day_subject_image_id: day_subject.day_subject_images.first.to_param }

  before { sign_in client }
  before { assign(:day_subject, day_subject) }

  before do
    assign(:social_posts, { 'twitter' => Kaminari.paginate_array([social_post]).page(1).per(1) })
  end

  it 'displays twitter active tab' do
    render
    expect(rendered).to have_css('section#twitter.active')
  end
end
