require 'addressable/uri'
require 'securerandom'

module UrlShortener
  class Shorten
    SLUG_LENGTH_IN_BYTES = 5
    
    def initialize(url)
      generate_slug
      @uri = Addressable::URI.parse(url)
      rescue
        true
    end

    def generate_slug
      @slug = SecureRandom.hex(SLUG_LENGTH_IN_BYTES)
    end

    def shorten
      if !@uri.nil? && !@uri.scheme.nil? && !@uri.host.nil?
        File.join(@uri.scheme + '://' + @uri.host, @slug)
      end
    end
  end
end
