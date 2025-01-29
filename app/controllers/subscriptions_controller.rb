class SubscriptionsController < ApplicationController
  before_action :set_podcast!

  def create
    subscription = current_user.subscriptions.create(podcast: @podcast)

    respond_to do |format|
      if subscription.save
        flash[:notice] = "Your subscription was successfully created."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("podcast_frame", partial: "podcasts/podcast", locals: { podcast: @podcast }),
            turbo_stream.append("flash", partial: "shared/flash", locals: { message: notice })
          ]
        end       
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("podcast_frame", partial: "podcasts/podcast", locals: { podcast: @podcast }),
            turbo_stream.replace("alert", partial: "shared/errors", locals: { resource: @podcast })
          ]
        end
      end
      format.html { redirect_to @podcast, notice: notice }
    end
  end

  def destroy
    subscription = current_user.subscriptions.find_by(podcast: @podcast)

    respond_to do |format|
      if subscription&.destroy
        flash[:notice] = "Your subscription was successfully deleted."
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("podcast_frame", partial: "podcasts/podcast", locals: { podcast: @podcast }),
            turbo_stream.append("flash", partial: "shared/flash", locals: { message: notice })
          ]
        end       
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("podcast_frame", partial: "podcasts/podcast", locals: { podcast: @podcast }),
            turbo_stream.replace("alert", partial: "shared/errors", locals: { resource: @podcast })
          ]
        end
      end
      format.html { redirect_to @podcast, notice: notice }
    end
  end

  private

  def set_podcast!
    @podcast = Podcast.find_by(id: params[:podcast_id])
  end
end