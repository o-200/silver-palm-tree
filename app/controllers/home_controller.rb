class HomeController < ApplicationController
  allow_unauthenticated_access

  def index
    @random_podcast = Podcast.offset(rand(Podcast.count)).first # TODO: use cron
    @last_podcast = Podcast.last
  end
end
