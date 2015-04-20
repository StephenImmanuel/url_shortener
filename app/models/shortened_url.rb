class ShortenedUrl < ActiveRecord::Base
  before_validation :url, presence: true
  validates_url :url, :schemes => ['ftp','https','http']
  validates :short_url, presence: true
  validates_uniqueness_of :url
  validates_uniqueness_of :short_url, message: 'please try again'
end
