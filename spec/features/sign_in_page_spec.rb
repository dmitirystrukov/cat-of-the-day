require 'rails_helper'

RSpec.describe 'Sign in page', type: :feature do
  it 'displays demo information' do
    visit new_user_session_path

    expect(page).to have_content 'Demo credentials'
    expect(page).to have_content 'consumer@example.com - password'
    expect(page).to have_content 'client@example.com - password'
    expect(page).to have_content "As client you can create day subjects and upload images to them,\n
                                                                      track statistics for all user social posts"
    expect(page).to have_content "As consumer you can connect social profiles and send social posts,\n
                                                                                       track personal statistics"
  end
end
