class User < ApplicationRecord
    has_many :trophies

    def get_highest_level_trophy(trophy_type)
        highest_level_trophy = self.trophies.where(trophy_type: trophy_type).order(level: :desc).first
        highest_level_trophy ? (return highest_level_trophy.level) : (return 0)
    end

    def add_coin(coin_value)
        coin = CollectedCoin.new(user_id: self.id, value: coin_value)
        if coin.save
            update_total_coins_value(coin_value)
            return { status: :created, object: coin.to_json }
        else
            return { status: :bad_request, object: coin.errors }
        end
    end
    
    def add_monster_killed(monster_id)
        monster_killed = KilledMonster.new(user_id: self.id, monster_id: monster_id)
        if monster_killed.save
            update_monsters_killed(monster_id)
            return { status: :created, object: monster_killed.to_json }
        else
            return { status: :bad_request, object: monster_killed.errors }
        end
    end

    def add_death(timestamp)
        death = Death.new(user_id: self.id, timestamp: timestamp)
        if death.save
            update_death_count
            return { status: :created, object: death.to_json }
        else
            return { status: :bad_request, object: death.errors }
        end
    end

    def update_monsters_killed(monster_id)
        monster_name = Monster.find(monster_id).name
        if monster_name == "bowser"
            self.update(bowsers_killed: (self.bowsers_killed or 0) + 1)
        else
            self.update(turtles_killed: (self.turtles_killed or 0) + 1)
        end
    end

    def update_total_coins_value(coin_value)
        self.update(total_coins: (self.total_coins or 0) + coin_value)
    end

    def update_death_count
        self.update(total_deaths: (self.total_deaths or 0) + 1)
    end

end
