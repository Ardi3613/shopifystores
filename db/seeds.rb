# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ShopifyStore.create(title: 'store 1', url: 'www.store1.com', )

ShopifyStore.create([
                              { title: 'store1', industry: 'location1', url: 'www.store1.com', top_selling_url: 'www.store1.com/category', instagram_url: 'qweqwe', facebook_url: 'example.com', pintrest_url: 'example.com', twitter_url: 'example.com/store1'},
                              { title: 'store2', industry: 'location2', url: 'www.store2.com', top_selling_url: 'www.store1.com/category', instagram_url: 'qweqwe', facebook_url: 'example.com', pintrest_url: 'example.com', twitter_url: 'twitter.com/store2'},
                              { title: 'store3', industry: 'location3', url: 'www.store3.com', top_selling_url: 'www.store1.com/category', instagram_url: 'qweqwe', facebook_url: 'example.com', pintrest_url: 'example.com', twitter_url: 'twitter.com/store3'},
                              { title: 'store4', industry: 'location4', url: 'www.store4.com', top_selling_url: 'www.store1.com/category', instagram_url: 'qweqwe', facebook_url: 'example.com', pintrest_url: 'example.com', twitter_url: 'twitter.com/store4'},
                              { title: 'store5', industry: 'location5', url: 'www.store5.com', top_selling_url: 'www.store1.com/category', instagram_url: 'qweqwe', facebook_url: 'example.com', pintrest_url: 'example.com', twitter_url: 'twitter.com/store5'},
                              { title: 'store6', industry: 'location5', url: 'www.store6.com', top_selling_url: 'www.store1.com/category', instagram_url: 'qweqwe', facebook_url: 'example.com', pintrest_url: 'example.com', twitter_url: 'twitter.com/store6'}
                            ])