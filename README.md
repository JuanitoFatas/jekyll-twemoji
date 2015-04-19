# Jekyll::Twemoji

[![Build Status](https://img.shields.io/travis/JuanitoFatas/jekyll-twemoji.svg?style=flat-square)](https://travis-ci.org/JuanitoFatas/jekyll-twemoji)
[![Gem Version](https://img.shields.io/gem/v/jekyll-twemoji.svg?style=flat-square)](https://rubygems.org/gems/jekyll-twemoji)

Twemoji plugin for Jekyll in Pure Ruby.

## Installation

Add this in your jekyll-powered site's `Gemfile`:

```
gem "jekyll-emoji"
```
And then execute:

```
$ bundle
```

Then add this to your site's `_config.yml`:

```yml
gems:
  - jekyll-emoji
```

Use Twemoji like you aways do:

```markdown
I give this plugin :thumbsup:!
```

Note that in Twemoji, a :+1: is called `:thumbsup:`, not `:+1:`.

## Attribution Requirements

Please follow the [Attribution Requirements](https://github.com/twitter/twemoji#attribution-requirements) as stated on the official [Twemoji](https://github.com/twitter/twemoji) project.

## Configuration

```
jekyll-twemoji:
  image_type: "png" # defaults to "svg"
```

That's it. Enjoy! :heart_eyes:

## Contributing

1. Fork it ( https://github.com/[my-github-username]/jekyll-twemoji/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

MIT License. See [LICENSE](LICENSE) for details.