class User < ApplicationRecord

    def update_total_coins_value(incoming_coin_value)
        update(:total_coins, self.total_coins + incoming_coin_value)
    end

end
