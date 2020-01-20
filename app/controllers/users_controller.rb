class UsersController < ApplicationController
    before_action :set_user

    def set_user
        @user = User.find(params[:user_id])
    end

    def trophies
        render json: @user.trophies.to_json, status: :ok
    end

    def users_params
        params.permit(:user_id)
    end


end
  