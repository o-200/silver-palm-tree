require 'rails_helper'

RSpec.feature "Sessions#create", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
  end

  scenario "User sees the sign in form with email and password fields" do
    within "turbo-frame#podcast_frame" do
      expect(page).to have_selector("label[for='email_address']", text: "Email Address")
      expect(page).to have_selector("input[type='email'][name='email_address'][required][autofocus][autocomplete='username'][placeholder='Enter your email address']")

      expect(page).to have_selector("label[for='password']", text: "Password")
      expect(page).to have_selector("input[type='password'][name='password'][required][autocomplete='current-password'][placeholder='Enter your password'][maxlength='72']")

      expect(page).to have_selector("input[type='submit'][value='Sign in']")
      expect(page).to have_link("Sign Up", href: new_user_path)
      expect(page).to have_link("Forgot password?", href: new_password_path)
    end
  end

  scenario "User successfull sign in" do
    within "turbo-frame#podcast_frame" do
      fill_in "email_address", with: user.email_address
      fill_in "password",      with: user.password

      click_button "Sign in"
    end

    expect(page).to have_selector("#flash .flash__message", text: "Successfully sign in!")
  end

  scenario "User typing wrong data and has error" do
    within "turbo-frame#podcast_frame" do
      fill_in "email_address", with: user.email_address
      fill_in "password",      with: 'wrong'

      click_button "Sign in"
    end

    expect(page).to have_content("Wrong email or password")
  end
end
