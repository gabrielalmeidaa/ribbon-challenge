Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/actions/collected_coin', to: 'game_actions#collected_coin'
  post '/actions/killed_monster', to: 'game_actions#killed_monster'
  post '/actions/player_death', to: 'game_actions#player_death'

  get '/user/:user_id/trophies', to: 'users#trophies'

end
