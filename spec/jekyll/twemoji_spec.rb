require "spec_helper"

describe Jekyll::Twemoji do
  let(:config_overrides) { Hash(nil) }

  let(:configs) do
    Jekyll.configuration(
      config_overrides.merge!({
        "skip_config_files" => true,
        "collections" => {
          "docs" => { "output" => true },
          "secret" => {}
        },
        "source" => fixtures_dir,
        "destination" => fixtures_dir("_site")
      })
    )
  end

  let(:site) { Jekyll::Site.new(configs) }

  let(:emoji) do
    site.generators.find do |generator|
      generator.class.name.eql?("Jekyll::Twemoji")
    end
  end

  let(:result) do
    "<img class='emoji' draggable='false' title=':thumbsup:' alt='👍' src='https://twemoji.maxcdn.com/svg/1f44d.svg'>"
  end

  before do
    site.read
    (site.pages + site.posts + site.docs_to_write).each { |p| p.content.strip! }
    site.generate
  end

  it "is instantiated with the site" do
    expect(emoji).not_to be nil
  end

  it "is a Jekyll::Twemoji object" do
    expect(emoji).to be_a Jekyll::Twemoji
  end

  it "saves the site config for later use" do
    expect(emoji.config).to eq site.config
  end

  it "image type by default will suite what Twemoji expected" do
    expect(emoji.image_type).to eq ".svg"
  end

  context "with a image type of png" do
    let(:image_type) { "png" }
    let(:config_overrides) do
      {
        "jekyll-twemoji" => { "image_type" => image_type }
      }
    end

    it "fetches the custom image type from the config" do
      expect(emoji.image_type).to eq ".#{image_type}"
    end

    it "respects the new image type when emojifying" do
      expect(
        site.posts.first.content
      ).to eq(
        "<img class='emoji' draggable='false' title=':thumbsup:' alt='👍' src='https://twemoji.maxcdn.com/16x16/1f44d.png'>"
      )
    end
  end

  it "correctly replaces the emoji with the img in posts" do
    expect(site.posts.first.content).to eq result
  end

  it "correctly replaces the emoji with the img in pages" do
    expect(site.pages.first.content).to eq result
  end

  it "correctly replaces the emoji with the img in collection documents" do
    expect(site.collections["docs"].docs.first.content).to eq result
  end

  it "not replace emoji if collection document won't output" do
    expect(site.collections["secret"].docs.first.content).to eq ":thumbsup:\n"
  end

  it "does not mangle liquid templates" do
    expect(
      site.collections["docs"].docs.last.content
    ).to eq(
      "#{result} <a href=\"{{ page.url }}\">{{ page.path }}</a>"
    )
  end
end
