require 'rails_helper'

RSpec.feature "Podcasts#index", type: :feature do
  before do
    10.times { FactoryBot.create(:podcast) }
    visit podcasts_path
  end

  context do
    context "podcast cards" do
      scenario 'container frame' do
        expect(page).to have_selector("turbo-frame#podcast_frame")
      end

      scenario 'sees all podcast cards' do
        expect(page).to have_css('.card',                  count: 10)
        expect(page).to have_css('.card-title',            count: 10)
        expect(page).to have_css('a.text-decoration-none', count: 10)
        expect(page).to have_css('.card-footer',           count: 10)
        expect(page).to have_css('img.card-img-top',       count: 10)
      end
    end
  end
end
