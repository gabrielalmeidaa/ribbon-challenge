require 'rails_helper'

RSpec.describe KilledMonster, type: :model do 
  
  describe "model validations" do
    
    it "should not accept id from non-existent monster" do
      killed_monster = FactoryBot.build(:killed_monster, monster_id: 200)
      expect(killed_monster).to_not be_valid
    end

    it "should not accept id from non-existe.tnt user" do
      killed_monster = FactoryBot.build(:killed_monster, user_id: 200)
      expect(killed_monster).to_not be_valid
    end

    it "should accept record with valid attributes" do
      user = FactoryBot.create(:user, id: 2)
      monster = FactoryBot.create(:monster, id: 1)
      killed_monster = FactoryBot.build(:killed_monster, user_id: user.id, monster_id: monster.id)
      expect(killed_monster).to be_valid
    end
  end
  
end
