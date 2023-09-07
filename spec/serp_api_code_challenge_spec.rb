require 'spec_helper'

describe SerpApiCodeChallenge do
  describe '#run' do
    subject { described_class.run}

    it 'produces expected results' do
      expect(described_class.run).to eq(described_class.expected_results)
    end
  end
end