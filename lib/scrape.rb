require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'watir'

  browser = Watir::Browser.start "http://indistreet.com/en/korea/artist?page=1"

  page_html = Nokogiri::HTML.parse(browser.html)

  #grab all links to artist pages
  # page_html.css('a.thumbLink.inited').each do |link|
  # 	puts link["href"]
  # end

  #grab all links to artists pages
  # page_html.css('ul.paging li a').each do |link|
  # 	puts link["href"]
  # end