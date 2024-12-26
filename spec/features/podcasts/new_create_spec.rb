require 'rails_helper'

RSpec.feature "Podcasts#edit", type: :feature do
  before do
    visit new_podcast_path
  end

  context 'user sees' do
    scenario "the podcast creation form" do
      expect(page).to have_content("Создать Podcast")
      expect(page).to have_field('podcast[title]')
      expect(page).to have_field('podcast[description]')
      expect(page).to have_field('podcast_photo')
      expect(page).to have_field('podcast_audio')
    end
  end

  # context 'user updates the podcast' do
  # scenario "successfully updates the podcast title and description" do
  #   fill_in 'podcast[title]', with: "Updated Podcast Title"
  #   fill_in 'podcast[description]', with: "Updated description."
  #   click_button 'Submit Podcast'

  #   expect(page).to have_content("Podcast was successfully updated.")
  #   expect(page).to have_content("Updated Podcast Title")
  #   expect(page).to have_content("Updated description.")
  # end

  #   scenario "uploads a new photo" do
  #     attach_file('podcast[photo]', Rails.root.join('spec/fixtures/files/sample_image.png'))
  #     fill_in 'podcast[title]', with: "Updated Podcast Title"
  #     fill_in 'podcast[description]', with: "Updated description."
  #     click_button 'Submit Podcast'

  #     expect(page).to have_content("Podcast was successfully updated.")
  #   end

  #   scenario "uploads a new audio file" do
  #     attach_file('podcast[audio]', Rails.root.join('spec/fixtures/files/sample_audio.mp3'))
  #     fill_in 'podcast[title]', with: "Updated Podcast Title"
  #     fill_in 'podcast[description]', with: "Updated description."
  #     click_button 'Submit Podcast'

  #     expect(page).to have_content("Podcast was successfully updated.")
  #   end
  # end

  # context 'user navigates back' do
  #   scenario "returns to the podcast show page" do
  #     click_link "Назад"
  #     expect(current_path).to eq(podcast_path(podcast))
  #   end
  # end
end
