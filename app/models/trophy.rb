class Trophy < ApplicationRecord
    belongs_to :user
    enum trophy_type: [:collected_coins, :deaths, :bowsers_killed, :turtles_killed]
end
