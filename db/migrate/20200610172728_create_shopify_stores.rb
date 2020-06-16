class CreateShopifyStores < ActiveRecord::Migration[6.0]
  def change
    create_table :shopify_stores do |t|
      t.string   :url
      t.text     :industry
      t.string   :title
      t.string   :top_selling_url
      t.string   :instagram_url
      t.string   :facebook_url
      t.string   :pintrest_url
      t.string   :twitter_url

      t.timestamps
    end
  end
end
