require 'rails_helper'

RSpec.feature "Podcasts#show", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:podcast) do
    FactoryBot.create(:podcast, title: Faker::Alphanumeric.alpha(number: 10),
                                description: Faker::Markdown.emphasis,
                                user: user)
  end

  context 'any user see' do
    before do
      visit podcast_path(podcast)
    end

    scenario "podcast details" do
      expect(page).to have_content(podcast.title)
      expect(page).to have_content(podcast.description)
      expect(page).to have_content(podcast.created_at)
    end

    scenario "special notice cuz no photo" do
      expect(page).to have_selector("div.alert.alert-warning", text: "No Photo Available!")
      expect(page).to have_selector("div.alert.alert-warning", text: "No Audio Available!")
    end

    scenario "subscribe button" do
      expect(page).to have_button(id: "subscribe_button")
    end
  end

  context 'unauthenticated user' do
    before do
      visit podcast_path(podcast)
    end

    scenario "does not see manipulation buttons" do
      expect(page).not_to have_link("Редактировать Podcast", href: edit_podcast_path(podcast))
      expect(page).not_to have_button("Удалить Podcast")
    end

    scenario "try to subscribe" do
      click_button(id: "subscribe_button")

      expect(page).to have_button("Sign in")
    end
  end

  context 'authenticated user see' do
    before do
      sign_in
      visit podcast_path(podcast)
    end

    scenario "manipulation buttons" do
      expect(page).to have_link("Редактировать Podcast", href: edit_podcast_path(podcast))
      expect(page).to have_button("Удалить Podcast")
    end
  end

  context 'subscriber see' do
    before do
      sign_in
      visit podcast_path(podcast)
      click_button(id: "subscribe_button")
    end

    scenario "unsubscribe button" do
      expect(page).to have_button(id: "unsubscribe_button")
    end

    scenario "subscribe button" do
      click_button(id: "unsubscribe_button")

      expect(page).to have_button(id: "subscribe_button")
    end
  end
end
