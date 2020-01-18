class GameActionsController < ApplicationController
  before_action :set_current_player
  after_action { |controller| controller.notify_trophy_service(params[:action], @current_player.id) }

  def set_current_player
    @current_player = User.find(params[:user_id])
  end

  def collected_coin
    CoinCollected.create(user_id: @current_player.id, value: coin_value)
    @current_player.update_total_coins_value(coin_value)
  end

  def monster_killed
    MonsterKilled.create( user_id: @current_player.id,
                          monster_id: params[:monster_id])
  end

  def player_death
    Death.create(user_id: @current_player.id, timestamp: params[:death_time])
  end

  def notify_trophy_service(action)
    TrophyService.update_on_action(action)
  end

  private
  def game_actions_params
    params.permit(:user_id, :monster_id, :action, :death_time)
  end
end
