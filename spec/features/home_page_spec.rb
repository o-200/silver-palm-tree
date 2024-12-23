require 'rails_helper'

RSpec.feature "Home Page", type: :feature do
  before do
    user = User.create!(email: "email@gmail.com", password: 'testpassword')
    Podcast.create!(user: user)
  end

  context "User see" do
    before { visit root_path }

    scenario "title" do
      expect(page).to have_title("Podcaster")
    end

    scenario "navbar" do
      expect(page).to have_selector("nav.navbar")
      expect(page).to have_link("Podcaster", href: "/")
    end

    scenario "main turbo frame" do
      expect(page).to have_selector("turbo-frame#main")
    end

    scenario "podcast turbo frame and see cards inside it" do
      expect(page).to have_selector("turbo-frame#podcast_frame")
      within("turbo-frame#podcast_frame") { expect(page).to have_selector(".card") }
    end
  end
end
