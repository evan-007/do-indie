require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'watir'
require 'csv'

browser = Watir::Browser.start "http://indistreet.com/en/korea/artist?page=1"

	File.open('list.txt', 'r') do |file|
		# while line = file.gets
		# 	puts line
		# end
		#/en/korea/artist/377
		while line = file.gets
			browser.goto ("http://indistreet.com""#{line}")
			page_html = Nokogiri::HTML.parse(browser.html)
				# file2.puts page_html.css('.name')[0].text
				puts page_html.css("a.twitter").text
				puts page_html.css(".facebook.outline href")
				puts page_html.css("a.facebook").text
			
			end
		sleep rand(5)
		end
