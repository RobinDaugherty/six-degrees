require 'spec_helper'
require 'tweet_file'

describe TweetFile do
  let(:tweet_file) { TweetFile.new(filename) }
  context "with a valid file" do
    let(:filename) { File.expand_path('../../fixtures/sample_input.txt', __FILE__) }
    describe '#tweet_lines' do
      subject { tweet_file.tweet_lines }
      it 'returns the correct number of tweets' do
        expect(subject.count).to eq(13)
      end
      it 'returns TweetLine objects' do
        expect(subject.first).to be_kind_of(TweetLine)
      end
    end
  end
end
