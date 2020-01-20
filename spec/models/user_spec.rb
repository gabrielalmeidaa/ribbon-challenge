require 'rails_helper'

RSpec.describe User, type: :model do 
    
    describe ".update_total_coins_value" do
        it "should correctly sum all coin added values" do
            user = FactoryBot.create(:user, id: 1)
            user.add_coin(10)
            user.add_coin(200)
            user.add_coin(130)
            expect(user.total_coins).to equal 340.0
        end
    end

    describe ".update_monsters_killed" do
        let(:user) { FactoryBot.create(:user, id: 1) }
        let(:bowser) { FactoryBot.create(:monster, name: "bowser", id: 1 ) }
        let(:turtle) { FactoryBot.create(:monster, name: "turtle", id: 2) }
        
        before :each do
            bowser.save
            turtle.save
            user.add_monster_killed(1)
            user.add_monster_killed(1)
            user.add_monster_killed(2)
        end

        it "should correctly sum all turtles killed" do
           expect(user.turtles_killed).to equal 1.0
        end

        it "should correctly sum all bowsers killed" do
            expect(user.bowsers_killed).to equal 2.0
        end
    end

    describe ".update_death_count" do
        let(:user) { FactoryBot.create(:user, id: 1) }
        it "should correctly sum deaths added" do
            10.times { user.add_death(Date.today) }
            expect(user.total_deaths).to equal 10.0 
        end    
    end

    describe ".get_highest_level_trophy" do
        before :each do
            @user = FactoryBot.create(:user, id: 1)
            FactoryBot.create(:trophy, level: 1, trophy_type: :collected_coins, user_id: 1)
            FactoryBot.create(:trophy, level: 2, trophy_type: :collected_coins, user_id: 1)
        end
        
        it "returns correct trophy level registered on database" do
            expect(@user.get_highest_level_trophy(:collected_coins)).to equal 2
        end

        it "returns 0 when there's no trophies from type registered" do
            expect(@user.get_highest_level_trophy(:deaths)).to equal 0
        end
    end

end
