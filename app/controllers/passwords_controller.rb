class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    valid_user = User.find_by(email_address: params[:email_address])
    if valid_user
      PasswordsMailer.reset(valid_user).deliver_later
    end

    redirect_to new_session_path, notice: "パスワード再設定用のメールを送信しました。(未対応)"
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "パスワードがリセットされました"
    else
      redirect_to edit_password_path(params[:token]), alert: "パスワードが一致しません。."
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "パスワード再設定用のメールを送信しました。"
    end
end
