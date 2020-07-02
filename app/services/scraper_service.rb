require 'mechanize'

class ScraperService

  USER_AGENTS = %w('Linux Firefox' 'Linux Konqueror' 'Linux Mozilla' 'Mac Firefox' 'Mac Mozilla' 'Mac Safari 4' 'Mac Safari' 'Windows Chrome' 'Windows IE 6' 'Windows IE 7' 'Windows IE 8' 'Windows IE 9' 'Windows IE 10' 'Windows IE 11' 'Windows Edge' 'Windows Mozilla' 'Windows Firefox' 'iPhone' 'iPad' 'Android' )

  def scrape_links_website
    puts 'clearing store'
    ShopifyStore.destroy_all
    puts 'All stores cleared'
    puts '**********************************Started Scraping******************************************'
    all_links = []
    domain = "https://myip.ms/browse/sites/"
    remaining_link = "/ownerID/376714/ownerIDii/376714/sort/1/asc/1#sites_tbl_top"
    (1..4607).each do |index|
      link = domain + index.to_s + remaining_link
      all_links << link
    end
    # url = 'https://myip.ms/browse/sites/1/ownerID/376714/ownerIDii/376714/sort/1/asc/1#sites_tbl_top'
    agent = Mechanize.new
    agent.user_agent = USER_AGENTS.sample
    all_links.each_with_index do |link, index|
      puts '***********************************************************************************'
      puts "Number: #{index + 1}"
      puts "Visiting link: #{link}"
      scrap(link, agent)
      puts "finished: #{link}"
      puts '***********************************************************************************'
    end

  end

  def scrap(url, agent)
    response = agent.get(url)
    links = response.css('#sites_tbl').css('tbody').css('tr > .row_name')
    links.each_with_index do |link, index|
      begin
        url = link.css('a').text
        puts "######################  Number: #{index + 1} out of #{links.count} #############################"
        puts "url is #{url}"
        complete_url = 'https://' + url
        single_site_response = agent.get(complete_url)
        if single_site_response.blank?
          title = 'domain of this website is expired, cant get title of this site'
          top_selling_url = url + '/collections/all?sort_by=best-selling'
          facebook_link = 'https://www.facebook.com/' + url.split('.')&.first
          instagram_link = 'https://www.instagram.com/' + url.split('.')&.first
          pinterest_link = 'https://www.pinterest.com/' + url.split('.')&.first
          twitter_link = 'https://twitter.com/' + url.split('.')&.first
        else
          title = single_site_response.css('head > title').text.squish
          facebook_link = single_site_response.links.select { |x| x&.href&.include?('www.facebook.com') }&.first&.href
          twitter_link = single_site_response.links.select { |x| x&.href&.include?('twitter.com') }&.first&.href
          instagram_link = single_site_response.links.select { |x| x&.href&.include?('instagram.com') }&.first&.href
          pinterest_link = single_site_response.links.select { |x| x&.href&.include?('pinterest.co') }&.first&.href

          top_selling_url = url + '/collections/all?sort_by=best-selling'

          facebook_link = facebook_link.blank? ? 'https://www.facebook.com/' + url.split('.')&.first : social_link_correction(facebook_link)
          instagram_link = instagram_link.blank? ? 'https://www.instagram.com/' + url.split('.')&.first : social_link_correction(instagram_link)
          pinterest_link = pinterest_link.blank? ? 'https://www.pinterest.com/' + url.split('.')&.first : social_link_correction(pinterest_link)
          twitter_link = twitter_link.blank? ? 'https://twitter.com/' + url.split('.')&.first : social_link_correction(twitter_link)
        end
        store = ShopifyStore.new(
          url: url,
          title: title,
          instagram_url: instagram_link,
          facebook_url: facebook_link,
          pintrest_url: pinterest_link,
          twitter_url: twitter_link,
          top_selling_url: top_selling_url
        )
        puts '*************************Shopify store details*************************************'
        puts store
        if store.save
          puts 'Store successfully created'
        else
          puts "Error:: #{store.errors.join(' ')}"
        end
      rescue StandardError => e
        puts "StandardError Error:: #{e}"
        next
      rescue OpenURI::HTTPError => e
        puts "HTTPError Error:: #{e}"
        next
      end
      puts "**********************************Ended #### Number: #{index + 1}  ******************************************"
    end
  end

  def social_link_correction(link)
    if link[0..3] != 'http'
      link = link.prepend('https:')
    end
    link
  end
end
