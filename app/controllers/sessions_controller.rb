class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    respond_to do |format|
      if user = User.authenticate_by(params.permit(:email_address, :password))
        start_new_session_for user
        notice = "Successfully sign in!"

        format.turbo_stream do
          flash[:notice] = notice
          render turbo_stream: turbo_stream.action(:redirect, root_path)
        end

        format.html { redirect_to root_path, notice: notice }
      else
        notice = "Wrong email or password"

        format.turbo_stream do
          flash[:notice] = notice
          render turbo_stream: turbo_stream.action(:redirect, login_path)
        end
        format.html { redirect_to login_path, notice: notice }
      end
    end
  end

  def destroy
    terminate_session

    respond_to do |format|
      notice = "Successfully sign out!"

      format.turbo_stream do
        flash[:notice] = notice
        render turbo_stream: turbo_stream.action(:redirect, root_path)
      end

      format.html { redirect_to root_path, notice: notice }
    end
  end
end
