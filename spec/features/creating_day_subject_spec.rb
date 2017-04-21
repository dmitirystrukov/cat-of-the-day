require 'rails_helper'

RSpec.describe 'Creating Day Subject', type: :feature do
  let!(:client) { create :user, :with_role, user_role: :client }
  let(:day_subject) { build :day_subject }

  before { sign_in client }

  scenario 'client creating day subject' do
    visit root_path

    click_link 'Create Day Subject'

    expect(current_path).to eq new_day_subject_path

    fill_in 'day_subject_title',       with: day_subject.title * 5
    fill_in 'day_subject_description', with: day_subject.description * 10

    submit_form

    expect(page).to have_content 'is too long (maximum is 40 characters)'
    expect(page).to have_content 'is too long (maximum is 500 characters)'

    fill_in 'day_subject_title',       with: ''
    fill_in 'day_subject_description', with: ''

    submit_form

    expect(page).to have_content 'is too short (minimum is 10 characters)'
    expect(page).to have_content 'is too short (minimum is 50 characters)'

    fill_in 'day_subject_title',       with: day_subject.title
    fill_in 'day_subject_description', with: day_subject.description

    submit_form

    expect(page).to have_css('.alert-notice', text: I18n.t('day_subjects.create.success'))

    expect(page).to have_content(day_subject.title)
    expect(page).to have_content(day_subject.description)
  end
end
