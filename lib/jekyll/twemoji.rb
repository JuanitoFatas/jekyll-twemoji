require "jekyll"
require "twemoji"

module Jekyll
  class Twemoji < Jekyll::Generator
    attr_reader :config
    safe true

    VALID_IMAGE_TYPES = %w(png svg).freeze

    def initialize(config = {})
      @config = config
    end

    def image_type
      @image_type ||=
        if config.key?("jekyll-twemoji") && config["jekyll-twemoji"].key?("image_type")
            validates_image_type(config["jekyll-twemoji"]["image_type"])
        else
          ".svg"
        end
    end

    def generate(site)
      site.pages.each { |page| emojify page }
      site.posts.each { |post| emojify post }
      site.docs_to_write.each { |doc| emojify doc }
    end

    def emojify(page)
      page.content = ::Twemoji.parse(page.content, file_ext: image_type)
    end

    private
      def validates_image_type(image_type)
        if image_type.start_with? "."
          fail "No need to put dot in front of image type: #{image_type}"
        end

        if VALID_IMAGE_TYPES.include? image_type
          ".#{image_type}" # Twemoji#parse file_ext option needs a leading dot.
        else
          fail "Image type not supported: #{image_type}. Supported image types are: #{VALID_IMAGE_TYPES.join(", ")}."
        end
      end
  end
end
