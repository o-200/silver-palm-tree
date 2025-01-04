class UsersController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        start_new_session_for @user
        notice_msg = "Your account successfully created!"

        format.turbo_stream do
          flash[:notice] = notice_msg
          render turbo_stream: turbo_stream.action(:redirect, after_authentication_url)
        end
        format.html { redirect_to after_authentication_url, notice: notice_msg }
      else
        notice_msg = @user.errors.full_messages.to_sentence

        format.turbo_stream do
          flash[:notice] = notice_msg
          render turbo_stream: turbo_stream.action(:redirect, new_user_url)
        end
        format.html { redirect_to new_user_url, notice: notice_msg }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation)
  end
end
