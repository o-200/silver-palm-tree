class PodcastsController < ApplicationController
  def index
    @random_podcast = Podcast.offset(rand(Podcast.count)).first # TODO: use cron
    @last_podcast = Podcast.last
  end

  def load_podcasts
    @podcasts = Podcast.take(4)
    render partial: "podcasts_list", locals: { podcasts: @podcasts }, layout: false
  end

  def show
  end

  def create
  end

  def new
  end

  def edit
  end

  def destroy
  end
end
