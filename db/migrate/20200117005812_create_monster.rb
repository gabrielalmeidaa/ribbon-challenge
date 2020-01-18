class CreateMonster < ActiveRecord::Migration[6.0]
  def change
    create_table :monsters do |t|
      t.string :name
    end
  end
end
