class ShortenedUrl < ActiveRecord::Base
  validates :url, presence: true
end
