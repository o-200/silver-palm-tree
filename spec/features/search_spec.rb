require 'rails_helper'

RSpec.feature "Searches#search", type: :feature, js: true do
  before do
    FactoryBot.create(:podcast, title: "Good Podcast", description: Faker::Markdown.emphasis)
    FactoryBot.create(:podcast, title: "Bad Podcast", description: Faker::Markdown.emphasis)
    FactoryBot.create(:podcast, title: "Bad or Good or Some Podcast", description: Faker::Markdown.emphasis)
    visit login_path # because this page does not display podcasts
  end

  context "elements exist" do
    scenario "search button" do
      expect(page).to have_selector("i.bi-search")
    end

    scenario "search field" do
      click_button(class: "search-button")

      expect(page).to have_field("title_search")
    end
  end

  context "find podcasts" do
    before { click_button(class: "search-button") }

    scenario "only some" do
      fill_in "title_search", with: "Good"

      expect(page).to have_selector(".search-title-result", wait: 0.6)
      expect(page).to have_content("Good Podcast")
      expect(page).to have_content("Bad or Good or Some Podcast")
      expect(page).not_to have_content("Bad Podcast")
    end

    scenario "only some other" do
      fill_in "title_search", with: "Bad"

      expect(page).to have_selector(".search-title-result", wait: 0.6)
      expect(page).to have_content("Bad Podcast")
      expect(page).to have_content("Bad or Good or Some Podcast")
      expect(page).not_to have_content("Good Podcast")
    end
  end
end
