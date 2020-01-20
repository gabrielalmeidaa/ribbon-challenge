class GameActionsController < ApplicationController
  before_action :set_user, only: [:collected_coin, :killed_monster, :player_death]
  skip_before_action :verify_authenticity_token
  after_action { |controller| controller.notify_trophy_service(request.params) }

  def set_user
    @user = User.find(params[:user_id])
  end

  def collected_coin
    response = @user.add_coin(params[:coin_value].to_i)
    render json: response[:object], status: response[:status]
  end

  def killed_monster
    response = @user.add_monster_killed(params[:monster_id])
    render json: response[:object], status: response[:status]
  end

  def player_death
    response = @user.add_death(params[:timestamp])
    render json: response[:object], status: response[:status]
  end

  def notify_trophy_service(request)
    TrophyService.perform_async(request)
  end

  private
  def game_actions_params
    params.permit(:user_id, :monster_id, :action, :death_time, :coin_value, :timestamp)
  end

end
