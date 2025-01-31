class SubscriptionsController < ApplicationController
  allow_unauthenticated_access only: :create
  before_action :only_user_access, only: :create
  before_action :set_podcast!

  def create
    subscription = current_user.subscriptions.create(podcast: @podcast)

    respond_to do |format|
      if subscription.save
        flash[:notice] = "You subscribed."
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
        flash[:notice] = "You unsubscribed."
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

  def only_user_access
    return if current_user

    respond_to do |format|
      notice = "You must log in or register to subscribe."

      format.turbo_stream do
        flash[:notice] = notice
        render turbo_stream: turbo_stream.action(:redirect, login_path)
      end
      format.html { redirect_to login_path, notice: notice }
    end
  end

  def set_podcast!
    @podcast = Podcast.find_by(id: params[:podcast_id])
  end
end
