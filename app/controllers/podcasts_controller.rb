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
    @podcast = Podcast.find_by(id: params[:id])
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new(podcast_params)

    if @podcast.save
      redirect_to @podcast
    else
      render :new
    end
  end

  def edit
    @podcast = Podcast.find_by(id: params[:id])
  end

  def update
    @podcast = Podcast.find(params[:id])

    if @podcast.update(podcast_params)
      redirect_to @podcast
    else
      render :edit
    end
  end

  def destroy
    @podcast = Podcast.find(params[:id])

    if @podcast.destroy
      redirect_to root_path
    else
      flash[:error] = "Podcast not found"
      redirect_to @podcast
    end
  end

  private

  def podcast_params
    params.require(:podcast).permit(:title, :description, :user_id, :photo, :audio)
  end
end
