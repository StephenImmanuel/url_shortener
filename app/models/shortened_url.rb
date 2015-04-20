require 'url_shortener'
class ShortenedUrl < ActiveRecord::Base
  include UrlShortener
  attr_accessor :short_url

  before_validation :url, presence: true
  validates_url :url, :schemes => ['ftp','https','http']
  validates :short_url, presence: true
  validates_uniqueness_of :url
  validates_uniqueness_of :short_url, message: 'please try again'

  def short_url
    if self.url.to_s.length > 0
      value = Shorten.new self.url
      write_attribute(:short_url, value.shorten)
    end
  end
end
