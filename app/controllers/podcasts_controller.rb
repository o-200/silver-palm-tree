class PodcastsController < ApplicationController
  def index
    @random_podcast = Podcast.offset(rand(Podcast.count)).first # TODO: use cron
    @last_podcast = Podcast.last
  end

  def load_list
    podcasts = get_podcasts

    render partial: "podcasts_list", locals: { podcasts: podcasts }
  end

  def show
    @podcast = Podcast.find_by(id: params[:id])
    render partial: "show", locals: { podcast: @podcast }
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = current_user.podcasts.build(podcast_params)

    if @podcast.save
      redirect_to @podcast
    else
      render :new, notice: @podcast.errors.full_messages
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

  def get_podcasts
    if current_user
      return current_user.podcasts if params[:filter] == 'my_podcasts'
    end

    Podcast.take(12)
  end

  def podcast_params
    params.require(:podcast).permit(:title, :description, :user_id, :photo, :audio)
  end
end
