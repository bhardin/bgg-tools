require 'spec_helper'

describe UpdateUserWorker do
  let(:user) { Fabricate(:user, name: 'logicalgambit') }
  let(:worker) { described_class.new }

  describe '#perform' do
    subject { worker.perform(user) }

    context 'when a user needs updating' do
      before :each do
        user.stub(:needs_updating?).and_return(true)
      end

      it 'creates games associations' do
        VCR.use_cassette('logicalgambit_user_request') do
          expect {subject}.to change {user.games.count}.by(136)
        end
      end

      it 'creates a job to update game data for each game' do
        VCR.use_cassette('logicalgambit_user_request') do
          GameUpdateWorker.should_receive(:perform_async).exactly(136).times
          subject
        end
      end
    end
  end
end
