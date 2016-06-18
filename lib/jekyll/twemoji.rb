require "jekyll"
require "twemoji"

module Jekyll
  class Twemoji < Jekyll::Generator
    attr_reader :config
    safe true

    JEKYLL_CONFIG_NAMESPACE = "jekyll-twemoji".freeze
    VALID_IMAGE_TYPES = %w(png svg).freeze

    def initialize(config = {})
      @config = config
    end

    def image_type
      @image_type ||=
        if config_inquiry? "image_type"
          validates_image_type(config["jekyll-twemoji"]["image_type"])
        else
          "svg"
        end
    end

    def generate(site)
      site.posts.each { |post| emojify post } unless jekyll_v3?
      site.pages.each { |page| emojify page }
      site.docs_to_write.each { |doc| emojify doc }
    end

    def emojify(page)
      page.content =
        ::Twemoji.parse(page.content, file_ext: image_type)
    end

    def jekyll_v3?
      ::Jekyll::VERSION.to_f >= 3.0
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
          image_type
        else
          fail "Image type not supported: #{image_type}. Supported image types are: #{VALID_IMAGE_TYPES.join(", ")}."
        end
      end
  end
end
