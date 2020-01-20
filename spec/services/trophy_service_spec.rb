require 'rails_helper'

RSpec.describe TrophyService do

    describe ".is_request_valid?" do
        let(:trophy_service) { TrophyService.new } 
        
        context "invalid requests" do
            it "should not accept request without action param" do 
                request = { user_id: 1 }
                expect(trophy_service.is_request_valid?(request)).to equal false
            end

            it "should not accept request without user_id param" do
                request = { action: "collected_coin" }
                expect(trophy_service.is_request_valid?(request)).to equal false
            end

            it "should not accept request with unexepected action" do
                request = { action: "trophy_acquired" }
                expect(trophy_service.is_request_valid?(request)).to equal false
            end
        end
        
        it "should accept valid request" do
            request = { user_id: 1, monster_id: 2, action: "killed_monster" }
            expect(trophy_service.is_request_valid?(request)).to equal true
        end 
    end

    describe ".get_current_trophy_level" do
        let(:trophy_service) { TrophyService.new } 
        
        it "should return the correct trophy level" do
            expect(trophy_service.get_current_trophy_level(0, trophy_service.coin_levels)).to  equal 0
            expect(trophy_service.get_current_trophy_level(980, trophy_service.coin_levels)).to  equal 2
            expect(trophy_service.get_current_trophy_level(99000, trophy_service.coin_levels)).to  equal 4
            expect(trophy_service.get_current_trophy_level(200000, trophy_service.coin_levels)).to  equal 5
        end
    end

    describe ".register_trophies" do
        let(:trophy_service) { TrophyService.new } 
        before :each do
            @user = FactoryBot.create(:user, id: 1)
        end

        it "should register the next level trophy" do
            trophy_service.register_trophies(@user, :deaths, 1)
            expect(@user.trophies.where(trophy_type: :deaths).count).to equal  1
        end

        it "should register multiple trophies when necessary" do
           trophy_service.register_trophies(@user, :deaths, 4) 
           expect(@user.trophies.where(trophy_type: :deaths).count).to equal 4
        end 
    end
    
end
 