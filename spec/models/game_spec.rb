require 'spec_helper'

describe Game do
  describe '#update_stuff' do
    context "when game has no bgg_id" do
      it "raises an error" do
        game.stub(:bgg_id).and_return(nil)
        expect {game.update_stuff}.to raise_error
      end
    end
  end
end
