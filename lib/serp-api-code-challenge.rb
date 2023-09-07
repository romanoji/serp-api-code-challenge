require 'rubygems'

require 'bundler/setup'
Bundler.require

loader = Zeitwerk::Loader.new
loader.tag = File.basename(__FILE__, '.rb')
loader.push_dir(__dir__)
loader.inflector.inflect(
  'serp-api-code-challenge' => 'SerpApiCodeChallenge'
)
loader.setup

module SerpApiCodeChallenge  
  def self.run
    File.open('resources/van-gogh-paintings.html', 'r') do |file|
      data = Scraper.new(file).run
      artworks = data.map { |d| ArtworkBuilder.new(**d.transform_keys(&:to_sym)).build }

      { 'artworks' => artworks }
    end
  end

  def self.expected_results
    JSON.load(File.open('resources/expected-array.json'))
  end

  def self.compare_results
    expected_results = SerpApiCodeChallenge.expected_results['artworks']
    actual_results = SerpApiCodeChallenge.run['artworks']

    puts "Incorrect number of items in dataset" if expected_results.size != actual_results.size
    puts "Data does not match (found #{(expected_results - actual_results).size} differences)" unless (expected_results - actual_results).empty?

    puts 'It works. Great job!'
  end
end