module SerpApiCodeChallenge
  class ArtworkBuilder
    GOOGLE_BASE_URL = 'https://www.google.com'

    def initialize(name:, extensions:, link:, image:)
      @name = name
      @extensions = extensions
      @link = link
      @image = image
    end

    def build
      { 'name' => name,
        'link' => GOOGLE_BASE_URL + link,
        'image' => image,
      }.tap do |a|
        a['extensions'] = extensions unless extensions.empty?
      end
    end

    private

    attr_reader :name, :extensions, :link, :image
  end
end