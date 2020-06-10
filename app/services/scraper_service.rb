require 'mechanize'

class ScraperService

  USER_AGENTS = %w('Linux Firefox' 'Linux Konqueror' 'Linux Mozilla' 'Mac Firefox' 'Mac Mozilla' 'Mac Safari 4' 'Mac Safari' 'Windows Chrome' 'Windows IE 6' 'Windows IE 7' 'Windows IE 8' 'Windows IE 9' 'Windows IE 10' 'Windows IE 11' 'Windows Edge' 'Windows Mozilla' 'Windows Firefox' 'iPhone' 'iPad' 'Android' )

  def scrape_links_website
    url = 'https://myip.ms/browse/sites/1/ownerID/376714/ownerIDii/376714/sort/1/asc/1#sites_tbl_top'
    agent = Mechanize.new
    agent.user_agent = USER_AGENTS.sample

    response = agent.get(url)
    links = response.css('#sites_tbl')
  end
end
