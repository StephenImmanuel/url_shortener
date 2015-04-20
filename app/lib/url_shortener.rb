require 'addressable/uri'
require 'securerandom'

module UrlShortener
  class MinifyUrl
    SLUG_LENGTH_IN_BYTES = 5
    VALID_SCHEMES = ['http', 'https', 'ftp']
    attr_accessor :url_errors
    
    def initialize(long_url, base_url)
      @url_errors = Array.new
      @base_url = base_url
      generate_slug
      @uri = Addressable::URI.parse(long_url)
      rescue
        false
    end

    def valid_url
      if @uri.nil?
        @url_errors.push('Invalid Url')
        false
      elsif not VALID_SCHEMES.include? @uri.scheme 
        @url_errors.push('Invalid Http Method')
        false
      else
        true
      end  
    end

    def generate_slug
      @slug = SecureRandom.hex(SLUG_LENGTH_IN_BYTES)
    end

    def minify
      if valid_url  
        File.join(@base_url, @slug)
      end
    end
  end
end
