require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'watir'

	browser = Watir::Browser.start "http://indistreet.com/en/korea/artist?page=1"

	for n in 152..181 do
		browser.goto ("http://indistreet.com/en/korea/artist?page=""#{n}")
		page_html = Nokogiri::HTML.parse(browser.html)
		page_html.css('a.thumbLink.inited').each do |link|
		puts link["href"]
		end
    sleep rand(5)
	end



  # page_html = Nokogiri::HTML.parse(browser.html)

  #grab all links to artist pages from artist page
  page_html.css('a.thumbLink.inited').each do |link|
  	puts link["href"]
  end

  # grab all links to artist index pages 1-181
  # page_html.css('ul.paging li a').each do |link|
  #  	puts link["href"]
  #  end

