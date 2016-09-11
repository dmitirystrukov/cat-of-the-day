require 'rails_helper'

feature 'Home page', js: true do
  let!(:user) { create(:user, :with_role, user_role: :client) }

  context 'social links activation' do
    let(:socials) { User::SOCIAL_PROVIDERS }
    let!(:social_profile) { create(:social_profile, service_name: socials.first, user: user) }

    specify do
      login(user)

      expect(page).to have_css('li.active', count: 1)
      create(:social_profile, service_name: socials.last, user: user)

      visit root_path
      expect(page).to have_css('li.active', count: 2)
    end
  end

  context 'permission check' do
    specify do
      visit root_path

      expect(page).to_not have_link('Create Day Subject')
      expect(page).to_not have_link('Statistic')

      login(user)

      expect(page).to have_link('Create Day Subject')
      expect(page).to have_link('Statistic')

      user.remove_role :client
      user.add_role :user

      visit root_path

      expect(page).to_not have_link('Create Day Subject')
      expect(page).to_not have_link('Statistic')
    end
  end
end
