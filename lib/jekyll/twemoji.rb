require "jekyll"
require "twemoji"

module Jekyll
  class Twemoji < Jekyll::Generator
    attr_reader :config
    safe true

    JEKYLL_CONFIG_NAMESPACE = "jekyll-twemoji".freeze
    VALID_IMAGE_TYPES = %w(png svg).freeze
    VALID_IMAGE_SIZES = %w(16x16 32x32 72x72).freeze

    def initialize(config = {})
      @config = config
    end

    def image_type
      @image_type ||=
        if config_inquiry? "image_type"
          validates_image_type(config["jekyll-twemoji"]["image_type"])
        else
          ".svg"
        end
    end

    def image_size
      @image_size ||=
        if config_inquiry? "image_size"
          validates_image_sizes(config["jekyll-twemoji"]["image_size"])
        else
          "16x16"
        end
    end

    def generate(site)
      site.pages.each { |page| emojify page }
      site.posts.each { |post| emojify post }
      site.docs_to_write.each { |doc| emojify doc }
    end

    def emojify(page)
      page.content =
        ::Twemoji.parse(page.content, file_ext: image_type, image_size: image_size)
    end

    private

      def config_inquiry?(key)
        config.key?(JEKYLL_CONFIG_NAMESPACE) &&
        config[JEKYLL_CONFIG_NAMESPACE].key?(key)
      end

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

      def validates_image_sizes(image_size)
        if VALID_IMAGE_SIZES.include? image_size
          image_size
        else
          fail "Image size not supported: #{image_size}. Supported image sizes are: #{VALID_IMAGE_SIZES.join(", ")}."
        end
      end
  end
end
