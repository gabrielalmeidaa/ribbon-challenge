require 'rails_helper'

RSpec.describe CollectedCoin, type: :model do 

    describe "model validations" do
        
        it "should not accept values lower than 0" do
            collected_coin = FactoryBot.build(:collected_coin, value: -10)
            expect(collected_coin).to_not be_valid
        end

        it "should not accept id from non-existent user" do
            collected_coin = FactoryBot.build(:collected_coin, user_id: 10)
            expect(collected_coin).to_not be_valid
        end

        it "should create valid collected coin successfully" do
            user = FactoryBot.create(:user, id: 2)
            collected_coin = FactoryBot.build(:collected_coin, user_id: user.id)
            expect(collected_coin).to be_valid  
        end
        
    end
    
end
