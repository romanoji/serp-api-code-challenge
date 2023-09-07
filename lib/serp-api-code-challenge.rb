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

  end
end