class GameActionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  after_action { |controller| controller.notify_trophy_service(request.params) }

  def collected_coin
    @collected_coin = CollectedCoin.new(user_id: params[:user_id], value: params[:coin_value])
    if @collected_coin.save
      render json: @collected_coin.to_json, status: :created
    else
      render json: @collected_coin.errors, status: :bad_request
    end
  end

  def monster_killed
    @monster_killed = MonsterKilled.new(user_id: params[:user_id], monster_id: params[:monster_id])
    if @monster_killed.save
      render json: @monster_killed.to_json, status: :created
    else
      render json: @monster_killed.errors, status: :bad_request
    end
  end

  def player_death
    @death = Death.new(user_id: params[:user_id], timestamp: params[:death_time])
    if @death.save
      render json: @death.to_json, status: :created
    else
      render json: @death.errors, status: :bad_request
    end
  end

  def notify_trophy_service(request)
    TrophyService.perform_async(request)
  end

  private
  def game_actions_params
    params.permit(:user_id, :monster_id, :action, :death_time, :coin_value)
  end
end
