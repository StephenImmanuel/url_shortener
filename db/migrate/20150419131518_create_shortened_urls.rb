class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :url
      t.string :short_url

      t.timestamps null: false

      add_index :shortened_urls, :short_url, :unique => true
      add_index :shortened_urls, :url
    end
  end
end
