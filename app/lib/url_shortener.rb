require 'addressable/uri'
require 'securerandom'

module UrlShortener
  class Shorten
    SLUG_LENGTH_IN_BYTES = 5
    
    def initialize(url)
      @uri = Addressable::URI.parse(url)
      generate_slug
    end

    def generate_slug
      @slug = SecureRandom.hex(SLUG_LENGTH_IN_BYTES)
    end

    def shorten
      File.join(@uri.scheme + '://' + @uri.host, @slug)
    end
  end
end
