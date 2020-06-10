namespace :scraper do
  desc 'Scrap jobs from different sites'
  task :start_scraping => :environment do

    puts 'Started the service rake task'
    scraper = ScraperService.new
    scraper.scrape_links_website
  end
end