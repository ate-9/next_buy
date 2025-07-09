class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path, alert: "save 成功。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email_address, :password, :icon_color)
    end
end
