require 'csv'
require 'activerecord-import/base'
file = "#{Rails.root}/public/stores_data_50001_to_75109.csv"

namespace :stores do
  desc 'Export stores'
  task :export => :environment do
    puts 'Started exporting'

    columns = %w(url industry title top_selling_url instagram_url facebook_url pintrest_url twitter_url)
    CSV.open(file, 'w', write_headers: true, headers: columns) do |writer|
      ShopifyStore.last(25109).each do |store|
        writer << [store.url, store.industry, store.title, store.instagram_url, store.top_selling_url, store.facebook_url, store.pintrest_url, store.twitter_url ]
      end
    end
  end

  desc 'Export stores'
  task import: :environment do

    puts 'destroying stores'
    ShopifyStore.destroy_all
    puts 'destroying stores'
    stores = []
    CSV.foreach('./public/stores_data.csv', headers: true) do |row|
      stores << ShopifyStore.new(row.to_h)
    end
    if ShopifyStore.import(stores)
      puts 'stores are imported successfully'
    else
      puts 'an error occurred while importing cities'
    end
  end
end

