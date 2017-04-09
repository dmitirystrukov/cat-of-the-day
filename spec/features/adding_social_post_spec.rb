require 'rails_helper'

RSpec.describe 'Adding Social Post', type: :feature do
  let(:client)       { create :user, :with_role, user_role: :client }
  let!(:day_subject) { create :day_subject_with_image, user: client }

  let!(:consumer)       { create :user, :with_role, user_role: :consumer }
  let(:twitter_profile) { consumer.reload.social_profiles.first }

  let(:twitter_data) do
    { "consumer_key"=>"somekey", "consumer_secret"=>"somesecret", "access_token"=>"sometoken", "access_token_secret"=>"somesecret" }
  end

  before { sign_in consumer }

  scenario 'consumer adding social post', js: true do
    visit root_path

    expect(page).to have_css('a[href="/users/auth/twitter"]')
    expect(page).to have_css('a[href="/users/auth/facebook"]')

    find(:xpath, "//a[@href='/users/auth/twitter']").click

    expect(twitter_profile.service_name).to eq 'twitter'
    expect(twitter_profile.uid).to eq '999'
    expect(twitter_profile.user).to eq consumer
    expect(twitter_profile.data).to eq twitter_data

    expect(page).to have_css('li.active > .fa-twitter')

    click_link day_subject.title

    expect(page).to have_content day_subject.title
    expect(page).to have_content day_subject.description
  end
end
