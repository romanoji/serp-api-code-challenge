require 'spec_helper'

describe SerpApiCodeChallenge::Scraper do
  subject(:scraper) { described_class.new(html_file) }

  let(:html_file) { File.read('spec/resources/van-gogh-paintings.html') }

  describe "#run" do
    subject { scraper.run }

    let(:expected_results) { JSON.load(File.open('spec/resources/scraped-data.json')) }

    it 'returns scraped data from a webpage' do
      expect(subject).to eq(expected_results)
    end
  end
end