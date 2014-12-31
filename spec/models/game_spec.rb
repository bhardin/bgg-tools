require 'spec_helper'

describe Game do
  let(:game) { Game.new(name: "acquire", bgg_id: 5) }
  describe '#needs_updating?' do
    context "when game has no name" do
      it 'is true' do
        game.stub(:name).and_return(nil)
        expect(game.needs_updating?).to be_true
      end
    end

    context "when game hasn't been updated in 1 month" do
      it 'is true' do
        game.stub(:updated_at).and_return(Time.zone.now - 1.month - 1.second)
        expect(game.needs_updating?).to be_true
      end
    end

    context "when game hasn't been updated in 2 weeks" do
      it 'is false' do
        game.stub(:updated_at).and_return(Time.zone.now - 2.weeks)
        expect(game.needs_updating?).to be_false
      end
    end
  end

  describe '#update_stuff' do
    context "when game has no bgg_id" do
      it "raises an error" do
        game.stub(:bgg_id).and_return(nil)
        expect {game.update_stuff}.to raise_error
      end
    end
  end
end
