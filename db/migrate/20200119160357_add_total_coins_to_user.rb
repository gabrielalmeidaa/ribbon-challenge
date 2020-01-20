class AddTotalCoinsToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.float :total_coins
      t.float :bowsers_killed
      t.float :turtles_killed
      t.float :total_deaths
    end
  end
end
