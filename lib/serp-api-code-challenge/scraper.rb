module SerpApiCodeChallenge
  class Scraper
    CAROUSEL_TAG = 'g-scrolling-carousel'
    ITEM_CLASS = '.klitem'
    IMAGE_CSS = 'g-img img'
    TITLE_CLASS = '.kltat'
    META_CLASS = '.klmeta'
    IMG_TAG_ID_PREFIX = 'kximg'

    def initialize(io)
      @io = io
      @root_node = Nokolexbor::HTML(io)
      @base64_imgs_lookup = extract_base64_imgs
    end

    def run
      root_node.at_css(CAROUSEL_TAG).css(ITEM_CLASS).map do |node|
        ArtworkBuilder.new(name: extract_name(node),
                           extensions: extract_extensions(node),
                           link: extract_link(node),
                           image: extract_image(node))
                      .build
      end
    end

    private
    
    attr_reader :io, :root_node, :base64_imgs_lookup

    def extract_base64_imgs
      root_node
        .xpath("//script[contains(text(), #{IMG_TAG_ID_PREFIX})]")
        &.text
        &.scan(/(data\:image\/[^\;]+\;base64,.+?(?='\;)).+?(?=#{IMG_TAG_ID_PREFIX})(#{IMG_TAG_ID_PREFIX}\d+)/)
        &.map { |a| [a[1], a[0].delete('\\')] }
        &.to_h
    end

    def extract_name(node)
      node.at_css(TITLE_CLASS).content
    end

    def extract_extensions(node)
      meta_node = node.css(META_CLASS).map(&:content)
    end

    def extract_link(node)
      node.attribute('href').value
    end
    
    def extract_image(node)
      image_node = node.at_css(IMAGE_CSS)
      image_id = image_node.attribute('id').value

      base64_imgs_lookup[image_id]
    end
  end
end