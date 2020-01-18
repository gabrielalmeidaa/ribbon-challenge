class TrophyService
    include SuckerPunch::Job

    def perform(request)
        if is_request_valid? request
        end
    end

    def self.is_request_valid? request
        request.key?(:user_id) and is_action_param_valid?(request)
    end

    def self.is_action_param_valid? request
        request.key?(:action) and valid_actions.include? request[:action]
    end

    def self.valid_actions
        ["collected_coin", "killed_monster", "player_death"]
    end

end