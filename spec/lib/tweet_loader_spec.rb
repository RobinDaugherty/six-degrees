require 'spec_helper'
require 'tweet_loader'

describe TweetLoader do
  let(:tweet_loader) { TweetLoader.new(filename) }
  let(:filename) { nil }

  describe '#create_tweets' do
    before do
      allow(tweet_loader).to receive(:tweet_lines).and_return(tweet_lines)
      allow(tweet_loader).to receive(:tweet_for_tweet_line).and_return(*tweets)
    end
    let(:tweet_lines) {
      [
        double('TweetLine1'),
        double('TweetLine2'),
        double('TweetLine3'),
      ]
    }
    let(:tweets) {
      [
        double('Tweet1'),
        double('Tweet2'),
        double('Tweet3'),
      ]
    }
    subject { tweet_loader.create_tweets }
    it 'returns the converted Tweets' do
      expect(subject).to eq(tweets)
    end
  end

  describe '#tweet_lines' do
    before do
      allow(tweet_file).to receive(:tweet_lines).and_return(tweet_lines)
      allow(tweet_loader).to receive(:tweet_file).and_return(tweet_file)
    end
    let(:tweet_file) { double('TweetFile') }
    let(:tweet_lines) { double('tweet_lines') }
    subject { tweet_loader.send(:tweet_lines) }
    it 'gets tweet_lines from tweet_file' do
      expect(subject).to eq(tweet_lines)
      expect(tweet_file).to have_received(:tweet_lines)
    end
  end

  describe '#create_tweet_for_tweet_line' do
    subject { tweet_loader.send(:create_tweet_for_tweet_line, tweet_line) }
    let(:tweet_line) {
      instance_double('TweetLine', message: 'abc', user: 'a123', mentions: %w(b234 c567))
    }
    it { is_expected.to be_an_instance_of(Tweet) }
    it 'has the correct message' do
      expect(subject.message).to eq('abc')
    end
    it 'has the correct user' do
      expect(subject.user).to be_an_instance_of(User)
      expect(subject.user.name).to eq('a123')
    end
    context 'mentions' do
      it 'has the correct count' do
        expect(subject.mentions.count).to eq(2)
      end
      it 'are User objects' do
        expect(subject.mentions[0]).to be_an_instance_of(User)
        expect(subject.mentions[1]).to be_an_instance_of(User)
      end
      it 'have the correct name' do
        expect(subject.mentions[0].name).to eq('b234')
        expect(subject.mentions[1].name).to eq('c567')
      end
    end
  end

  describe '#tweet_file' do
    subject { tweet_loader.send(:tweet_file) }
    let(:filename) { 'abd1234' }
    let(:tweet_file) { double('TweetFile') }
    it 'creates a TweetFile instance' do
      expect(TweetFile).to receive(:new).with(filename).and_return(tweet_file)
      expect(subject).to eq(tweet_file)
    end
  end
end
