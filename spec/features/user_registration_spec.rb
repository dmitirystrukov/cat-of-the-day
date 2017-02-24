require 'rails_helper'

feature 'User registration', js: true do
  context 'verify registration' do
    let(:user) { build :user }

    specify do
      visit root_path

      find("a[href='#menu']").click
      expect(page).to have_css('h2', text: 'MENU')
      expect(page).to have_link('Home')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')

      click_link('Sign up')
      expect(page).to have_css('h2', text: 'SIGN UP')
      expect(page).to have_css('label', text: 'Email')
      expect(page).to have_css('label', text: 'Password')
      expect(current_path).to eq new_user_registration_path

      within 'form.new_user' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        fill_in 'user[password_confirmation]', with: user.password

        click_button('Sign up')
      end

      expect(current_path).to eq root_path
      find("a[href='#menu']").click

      expect(page).to have_link('Logout')
    end
  end
end
