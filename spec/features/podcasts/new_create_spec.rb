require 'rails_helper'

RSpec.feature "Podcasts#edit", type: :feature do
  let(:user)    { FactoryBot.create(:user)   }
  let(:podcast) { FactoryBot.build(:podcast) }

  before do
    sign_in user
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

  context 'user creates the podcast' do
    scenario "successfully create" do
      fill_in 'podcast[title]',       with: podcast.title
      fill_in 'podcast[description]', with: podcast.description
      click_button 'Submit Podcast'

      expect(current_path).to eq(podcast_path(Podcast.last))
      # expect(page).to have_content("Your podcast was successfully created.")
      expect(page).to have_content(podcast.title)
      expect(page).to have_content(podcast.description)
    end

    scenario "unsuccessfully create, sees errors" do
      fill_in 'podcast[title]',       with: '1'
      fill_in 'podcast[description]', with: podcast.description
      click_button 'Submit Podcast'

      expect(current_path).to eq(podcasts_path)
      expect(page).to have_content("Title is too short (minimum is 2 characters)")
    end

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
  end
end
