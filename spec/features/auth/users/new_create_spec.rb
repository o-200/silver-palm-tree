require 'rails_helper'

RSpec.feature "Sessions#create", type: :feature do
  let(:user_params) { attributes_for(:user) }

  before do
    visit register_path
  end

  scenario "User sees the sign up form" do
    within "turbo-frame#podcast_frame" do
      expect(page).to have_selector("label[for='user_email_address']", text: "Email Address")
      expect(page).to have_selector("input[type='email'][name='user[email_address]'][required][autofocus][autocomplete='username'][placeholder='Enter your email address']")

      expect(page).to have_selector("label[for='user_password']", text: "Password")
      expect(page).to have_selector("input[type='password'][name='user[password]'][required][autocomplete='current-password'][placeholder='Enter your password'][maxlength='72']")

      expect(page).to have_selector("label[for='user_password_confirmation']", text: "Confirm Password")
      expect(page).to have_selector("input[type='password'][name='user[password_confirmation]'][required][autocomplete='new-password'][placeholder='Confirm your password'][maxlength='72']")

      expect(page).to have_selector("input[type='submit'][value='Sign up']")
    end
  end


  scenario "User successfull sign up" do
    within "turbo-frame#podcast_frame" do
      fill_in "user[email_address]",         with: user_params[:email_address]
      fill_in "user[password]",              with: user_params[:password]
      fill_in "user[password_confirmation]", with: user_params[:password]

      click_button "Sign up"
    end

    expect(page).to have_selector("#flash .flash__message", text: "Your account successfully created!")
  end

  scenario "User got errors while sign up" do
    within "turbo-frame#podcast_frame" do
      fill_in "user[email_address]",         with: user_params[:email_address]
      fill_in "user[password]",              with: user_params[:password]
      fill_in "user[password_confirmation]", with: ""

      click_button "Sign up"
    end

    expect(page).to have_selector("#flash .flash__message", text: "Password confirmation doesn't match Password")
  end
end
