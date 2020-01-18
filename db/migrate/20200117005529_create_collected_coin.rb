class CreateCollectedCoin < ActiveRecord::Migration[6.0]
  def change
    create_table :collected_coins do |t|
      t.float :value
      t.references :user, foreign_key: true
    end
  end
end
