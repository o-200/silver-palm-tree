require 'rails_helper'

RSpec.feature "Podcasts#edit", type: :feature do
  let(:podcast) do
    FactoryBot.create(:podcast, title: Faker::ProgrammingLanguage.name,
                                description: Faker::Markdown.emphasis)
  end

  before do
    visit edit_podcast_path(podcast)
  end

  context 'user sees' do
    scenario "the current podcast details in the form" do
      expect(page).to have_content("Редактировать Podcast: #{podcast.title}")

      expect(find_field('podcast[title]').value).to       eq(podcast.title)
      expect(find_field('podcast[description]').value).to eq(podcast.description)
    end

    scenario "the form fields for uploading a photo and audio" do
      expect(page).to have_field('podcast_photo')
      expect(page).to have_field('podcast_audio')
    end

    scenario "the back button" do
      expect(page).to have_link("Назад", href: podcast_path(podcast))
    end
  end

  # context 'user updates the podcast' do
  scenario "successfully updates the podcast title and description" do
    title = "Updated Podcast Title"
    description = "Updated description."

    fill_in 'podcast[title]',       with: title
    fill_in 'podcast[description]', with: description
    click_button 'Submit Podcast'

    expect(page).to have_content("Your podcast was successfully updated.")
    expect(page).to have_content(title)
    expect(page).to have_content(description)
  end

  scenario "see error" do
    fill_in 'podcast[title]', with: '1'
    click_button 'Submit Podcast'

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

  context 'user navigates back' do
    scenario "returns to the podcast show page" do
      click_link "Назад"
      expect(current_path).to eq(podcast_path(podcast))
    end
  end
end
