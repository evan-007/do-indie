require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'watir'
require 'csv'
  

#scrapes indistreet venue pages 1 -32
# browser = Watir::Browser.start "http://indistreet.com/en/korea/venue?page=1"	
# 		page_html = Nokogiri::HTML.parse(browser.html)
# 		page_html.css('.paging li a').each do |link|
# 		puts link["href"]
# 		end
#     sleep rand(5)


#scrape indistreet venue info

browser = Watir::Browser.start "http://indistreet.com/"
CSV.open('street-venues.csv', "wb") do |csv|
  for n in 1..32 do 
    browser.goto("http://indistreet.com/en/korea/venue?page=""#{n}")
      page_html = Nokogiri::HTML.parse(browser.html)
      page_html.css('.entryPlace').each do |place|
        @name = place.css('h4').text.strip
        @address = place.css('.address').text.strip
        @area = place.css('.area').text.strip
        csv << [@name, @address, @area]
    end
  end
end


    sleep rand(5)


#do-indie site sucks to scrape

#scrapes for list of venues
  # browser = Watir::Browser.start "http://doindie.staging.wpengine.com/venues/"
# File.open('do-venues.txt', 'r') do |file|
#   while line = file.gets
#     browser.goto("#{line}")
#     page_html = Nokogiri::HTML.parse(browser.html)
#     name = page_html.css('h1').text
#     phone = page_html.css('html.csstransforms body.single div.canvas div.grid div.content article.post-10026 div.three-fourth div.col-2 div.post-meta div.post-meta-table div.post-artist div.cell div.inner').text
#     email = page_html.css('html.csstransforms body.single div.canvas div.grid div.content article.post-10026 div.three-fourth div.col-2 div.post-meta div.post-meta-table div.post-catalog-number div.cell div.inner').text
#     address = page_html.css('html.csstransforms body.single div.canvas div.grid div.content article.post-10026 div.three-fourth div.col-2 div.post-meta div.post-meta-table div.post-catalog-number div.cell div.inner').text
#     puts name
#     puts phone
#     puts email
#     puts address
#   end
# end
