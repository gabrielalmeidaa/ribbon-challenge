class CreateTrophyTable < ActiveRecord::Migration[6.0]
  def change
    create_table :trophies do |t|
      t.references :user, foreign_key: :true
      t.integer :level
      t.integer :trophy_type
    end
  end
end
