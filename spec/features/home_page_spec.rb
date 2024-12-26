require 'rails_helper'

RSpec.feature "Home Page", type: :feature do
  before do
    10.times { FactoryBot.create(:podcast) }
  end

  context do
    before { visit root_path }

    context 'header or navbar' do
      scenario "title" do
        expect(page).to have_title("Podcaster")
      end

      scenario "navbar" do
        expect(page).to have_selector("nav.navbar")
        expect(page).to have_link("Podcaster", href: root_path)
      end

      scenario "has auth links when user not signed in" do
        expect(page).to have_selector(".authentication")
        within(".authentication") { have_selector('a[btn btn-outline-success]',
                                    text: 'register',
                                    visible: true)
        }
        within(".authentication") { have_selector('a[btn btn-outline-primary]',
                                text: 'login',
                                visible: true)
        }
      end

      context "signed in" do
        let(:current_user) { create(:user) }

        before do
          sign_in current_user
          visit root_path
        end

        scenario "check for navbar-menu" do
          expect(page).to have_button('Menu')
          within('.dropdown-menu') do
            expect(page).to have_link('My podcasts',     href: podcasts_path(filter: 'my_podcasts'))
            expect(page).to have_link('Add new podcast', href: new_podcast_path)
            expect(page).to have_button('Sign Out')
          end
        end
      end
    end

    context "container" do
      scenario "main turbo frame" do
        expect(page).to have_selector("turbo-frame#main")
      end

      scenario "podcast turbo frame and see cards inside it" do
        expect(page).to have_selector("turbo-frame#podcast_frame")
        within("turbo-frame#podcast_frame") { expect(page).to have_selector(".card-group") }
        within(".card-group")               { expect(page).to have_selector(".card", count: 3) }
        within(".card-group")               { have_selector('a[data-turbo-frame="podcasts_list"]',
                                              text: 'Check it out!',
                                              visible: true)
        }
      end
    end
  end
end
