require 'rails_helper'

RSpec.feature "Podcasts#show", type: :feature do
  let(:podcast) do
    FactoryBot.create(:podcast, title: Faker::ProgrammingLanguage.name,
                                description: Faker::Markdown.emphasis)
  end

  before do
    visit podcast_path(podcast)
  end

  context 'user see' do
    scenario "podcast details" do
      expect(page).to have_content(podcast.title)
      expect(page).to have_content(podcast.description)
      expect(page).to have_content(podcast.created_at)
    end

    scenario "special notice cuz no photo" do
      expect(page).to have_selector("div.alert.alert-warning", text: "No Photo Available!")
      expect(page).to have_selector("div.alert.alert-warning", text: "No Audio Available!")
    end

    scenario "manipulation buttons" do
      expect(page).to have_link("Редактировать Podcast", href: edit_podcast_path(podcast))
      expect(page).to have_button("Удалить Podcast")
    end
  end
end
