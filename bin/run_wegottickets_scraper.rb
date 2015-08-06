require_relative '../lib/scraper'

scraper = Scraper.new('http://www.wegottickets.com/searchresults/all')
scraper.run
