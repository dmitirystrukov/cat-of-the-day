require 'rails_helper'

RSpec.describe 'User registration', type: :feature do
  it 'check registration fields' do
    visit new_user_registration_path

    expect(page).to have_field 'Email'
    expect(page).to have_select 'Selected role', options: %w(client consumer)
    expect(page).to have_field 'First name'
    expect(page).to have_field 'Last name'
    expect(page).to have_field 'Nickname'

    expect(page).to have_content 'Additional information'
    expect(page).to have_field 'Location'
    expect(page).to have_field 'Website'
  end
end
