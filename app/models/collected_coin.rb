class CollectedCoin < ApplicationRecord
    belongs_to :user, required: true
    validate :coin_value_should_be_positive

    def coin_value_should_be_positive
        if value <= 0
            errors.add(:value, "Coin value should be higher than 0.")
        end
    end

end
