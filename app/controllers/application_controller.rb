class ApplicationController < ActionController::Base
  include Authentication
  before_action :set_current_user

  private

    # ログイン中のユーザーを取得
    def set_current_user
      @current_user = Current.user
      @logged_in = @current_user.present?
    end
end
