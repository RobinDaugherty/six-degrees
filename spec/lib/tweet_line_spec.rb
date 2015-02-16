require 'spec_helper'
require 'tweet_line'

describe TweetLine do
  let(:tweet_line) { TweetLine.new(unparsed_message) }
  context "with a valid string" do
    let(:unparsed_message) {
      "leta: Emerson here refers to the military operations carried on from 1808 to 1814 in Portugal, Spain, and ... /cc @terrell_senger, @darrel_skiles"
    }
    describe '#user' do
      subject { tweet_line.user }
      it { is_expected.to eq("leta") }
    end
    describe '#message' do
      subject { tweet_line.message }
      it { is_expected.to eq("Emerson here refers to the military operations carried on from 1808 to 1814 in Portugal, Spain, and ... /cc @terrell_senger, @darrel_skiles") }
    end
    describe '#mentions' do
      subject { tweet_line.mentions }
      it { is_expected.to match_array(%w(terrell_senger darrel_skiles)) }
    end
  end
end
