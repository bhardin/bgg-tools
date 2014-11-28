require 'spec_helper'

describe User do
  let(:user) { User.new }

  describe "#collection" do
    subject { user.collection }

    it "returns the right data" do
      stub_request(:get, "http://www.boardgamegeek.com/xmlapi2/collection?username=").
         to_return(:status => 200, :body => File.new('spec/data/collection_data.json'))
    end
  end
end