require 'rails_helper'

feature 'Notification messages', js: true do
  let!(:user) { create(:user, :with_role, user_role: :client) }
  let!(:day_subject_with_image) { create(:day_subject_with_image, user: user) }

  it 'sign in notification' do
    visit new_user_session_path
    click_button('Log in')

    expect(page).to have_css('.alert-alert', text: 'Invalid Email or password.')
  end

  it 'sign up notification' do
    visit new_user_registration_path
    click_button('Sign up')

    expect(page).to have_text("2 ERRORS PROHIBITED THIS USER FROM BEING SAVED:")
    expect(page).to have_text("Email can't be blank")
    expect(page).to have_text("Password can't be blank")
  end

  it 'user interface notifcations' do
    login(user)
    expect(page).to have_css('.alert-notice', text: 'Signed in successfully.')

    visit new_day_subject_path
    click_button('Create Day subject')

    expect(page).to have_css('.error', text: 'is too short (minimum is 10 characters)')
    expect(page).to have_css('.error', text: 'is too short (minimum is 50 characters)')

    # TODO: Need fix bug with disappear input
    # expect(page).to have_selector("input[name='day_subject[day_subject_images_attributes][0][url]']")
  end
end
