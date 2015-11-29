lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "jekyll-twemoji"
  spec.version       = "1.0.1"
  spec.authors       = ["Juanito Fatas"]
  spec.email         = ["katehuang0320@gmail.com"]
  spec.summary       = %{Twemoji plugin for Jekyll in Pure Ruby.}
  spec.homepage      = "https://github.com/JuanitoFatas/jekyll-twemoji"
  spec.license       = "MIT"
  spec.files         = ["lib/jekyll/twemoji.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", ">= 2.0"
  spec.add_dependency "twemoji", "~> 1.1.0"
end
