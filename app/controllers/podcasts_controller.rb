class PodcastsController < ApplicationController
  def index
    podcasts = get_podcasts
    render partial: "podcasts_list", locals: { podcasts: podcasts }
  end

  def show
    @podcast = Podcast.find_by(id: params[:id])
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.build(podcast_params)

    respond_to do |format|
      if @podcast.save
        flash[:notice] = "Your podcast was successfully created."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("podcast_frame", partial: "podcasts/podcast", locals: { podcast: @podcast }),
            turbo_stream.append("flash", partial: "layouts/flash", locals: { message: notice })
          ]
        end
        format.html { redirect_to @podcast, notice: notice }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("form", partial: "podcasts/form", locals: { podcast: @podcast }),
            turbo_stream.replace("alert", partial: "layouts/errors", locals: { resource: @podcast })
          ]
        end
        format.html { render :new }
      end
    end
  end

  def edit
    @podcast = Podcast.find_by(id: params[:id])
  end

  def update
    @podcast = Podcast.find_by(id: params[:id])

    respond_to do |format|
      if @podcast.update(podcast_params)
        flash[:notice] = "Your podcast was successfully updated."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("podcast_frame", partial: "podcasts/podcast", locals: { podcast: @podcast }),
            turbo_stream.append("flash", partial: "layouts/flash", locals: { message: notice })
          ]
        end
        format.html { redirect_to @podcast, notice: "Your podcast was successfully updated." }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("form", partial: "podcasts/form", locals: { podcast: @podcast }),
            turbo_stream.replace("alert", partial: "layouts/errors", locals: { resource: @podcast })
          ]
        end
        format.html { render :new }
      end
    end
  end

  def destroy
    podcast = Podcast.find_by(id: params[:id])

    if current_user.podcast.destroy
      redirect_to root_path
    else
      flash[:error] = @podcast.errors.full_messages
      render :show, locals: { podcast: @podcast }
    end
  end

  private

  def get_podcasts
    # if current_user
    #   return current_user.podcasts if params[:filter] == "my_podcasts"
    # end

    Podcast.all
  end

  def podcast_params
    params.require(:podcast).permit(:title, :description, :photo, :audio)
  end
end
