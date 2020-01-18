require 'rails_helper'

RSpec.describe TrophyService do

    describe ".is_request_valid?" do
        context "invalid requests" do
            it "should not accept request without action param" do 
                request = { user_id: 1 }
                expect(TrophyService.is_request_valid?(request)).to equal false
            end

            it "should not accept request without user_id param" do
                request = { action: "collected_coin" }
                expect(TrophyService.is_request_valid?(request)).to equal false
            end

            it "should not accept request with unexepected action" do
                request = { action: "trophy_acquired" }
                expect(TrophyService.is_request_valid?(request)).to equal false
            end
        end
        
        it "should accept valid request" do
            request = { user_id: 1, monster_id: 2, action: "killed_monster" }
            expect(TrophyService.is_request_valid?(request)).to equal true
        end 
    end
    
end
