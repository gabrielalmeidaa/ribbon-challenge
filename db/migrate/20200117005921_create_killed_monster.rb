class CreateKilledMonster < ActiveRecord::Migration[6.0]
  def change
    create_table :killed_monsters do |t|
      t.references :user, foreign_key: true
      t.references :monster, foreign_key: true
    end
  end
end
