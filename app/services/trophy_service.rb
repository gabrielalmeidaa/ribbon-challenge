class TrophyService
    include SuckerPunch::Job

    def perform(request)
        if is_request_valid? request
            case request[:action]
            when "collected_coin"
                collected_coin_notification(request[:user_id])
            when "killed_monster"
                killed_monster_notification(request[:user_id], request[:monster_id])
            when "player_death"
                player_death_notification(request[:user_id])
            end
        end
    end

    def collected_coin_notification(user_id)
        user = User.find(user_id)
        current_level = get_current_trophy_level(user.total_coins, coin_levels)
        register_trophies(user, :collected_coins, current_level)        
    end

    def killed_monster_notification(user_id, monster_id)
        user = User.find(user_id)
        monster = Monster.find(monster_id)
        if monster.name == "bowser"
            current_level = get_current_trophy_level(user.bowsers_killed, self.killed_monster_levels)
            register_trophies(user, :bowsers_killed, current_level)
        elsif monster.name == "turtle"
            current_level = get_current_trophy_level(user.turtles_killed, self.killed_monster_levels)
            register_trophies(user, :turtles_killed, current_level)
        end
    end

    def player_death_notification(user_id)
        user = User.find(user_id)
        current_level = get_current_trophy_level(user.total_deaths, killed_monster_levels)
        register_trophies(user, :deaths, current_level)   
    end

    def register_trophies(user, trophy_type, current_level)
        highest_registered_trophy_level = user.get_highest_level_trophy(trophy_type)
        trophies_to_be_created = (highest_registered_trophy_level..current_level).to_a.drop(1)
        trophies_to_be_created.each do |trophy_level|
            Trophy.create(user_id: user.id, trophy_type: trophy_type, level: trophy_level)
        end
    end
    
    def is_request_valid?(request)
        request.key?(:user_id) and is_action_param_valid?(request)
    end

    def is_action_param_valid?(request)
        request.key?(:action) and valid_actions.include? request[:action]
    end

    def get_current_trophy_level(current_value, levels)
        return 5 if current_value > levels.last
        levels.each_with_index do |level, index|
            return index if current_value < level
        end
    end

    def valid_actions
        ["collected_coin", "killed_monster", "player_death"]
    end

    def coin_levels
        [1, 100, 1000, 10000, 100000]
    end

    def player_death_levels
        [1, 10, 25, 50, 100]
    end

    def killed_monster_levels
        [1, 100, 1000, 10000, 100000]
    end

end