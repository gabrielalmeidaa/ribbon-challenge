class TrophyService
    include SuckerPunch::Job

    def perform(action, user_id)
        byebug
    end

end