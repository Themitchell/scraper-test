# Scraper

The scraper uses 3 fundamental classes in order to to scrape the page. The first class is the `ListScraper` itself. This class collects together all of the listing pages required to access individual event pages. It does this by iterating over each listing pages "next" pagination button until there is no pagination left. This class then iterates over each of the listing pages, collects what data it can from the listing page and visits the events show page in order to pull more information. I used both pages in order to try and make up for some of the more flaky information on the listing page, or info which was marked up in such a way that we could not differentiate it from other data.

The second class is the `Event` class. When the `ListScraper` has completed parsing the pages for information, it pushes the info into a simple event class. The `Event` class is a simple struct object allowing us to collect data easily and convert it into a CSV format ready for output. One all date has been collected the `ListScraper` returns a list of `Event` objects.

Finally the `Event` objects returned by the `ListScraper` are passed to the `CSVwriter`. The `CSVWriter` simply iterates over the Events and pushes each `Event` onto a single line of the CSV file. The `CSVWriter` is nicely separated as it does not really care what the array of things it is writing is, as long as it responds to `to_csv`. Each CSV is writter to a timestamped file in order to version histroy the scrapes.


### Dependencies

Each class is individually tested using rspec, I used fakeweb in order to stub external web requests and provide simpler pages to scrape and test my work. Timecop allows me to do easier time stubbing and test file timestamping. The only non developments dependency is mechanize. This gem provides a wrapper around Nokogiri so that I can traverse the html structure of web page. This component is key to beong able to parse and scrape our page.