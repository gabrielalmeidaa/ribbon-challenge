class CreateDeath < ActiveRecord::Migration[6.0]
  def change
    create_table :deaths do |t|
      t.references :user, foreign_key: true
      t.timestamp :timestamp
    end
  end
end
