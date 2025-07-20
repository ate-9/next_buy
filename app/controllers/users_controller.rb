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
      redirect_to new_session_path, notice: "アカウント作成に成功しました🎉"
    else
      render :new, status: :unprocessable_entity, alert: "アカウント作成に失敗しました。もう一度作成お願いします。"
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email_address, :password, :icon_color)
    end
end
