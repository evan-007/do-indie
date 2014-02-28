require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'watir'
require 'csv'

browser = Watir::Browser.start "http://indistreet.com/en/korea/artist?page=1"

CSV.open("data.csv", "wb") do |csv|
	File.open('list.txt', 'r') do |file|
		# while line = file.gets
		# 	puts line
		# end
		#/en/korea/artist/377
		while line = file.gets
			browser.goto ("http://indistreet.com""#{line}")
			page_html = Nokogiri::HTML.parse(browser.html)
			File.open('names.txt', 'w') do |file2|
				file2.puts page_html.css('.name')[0].text
				file2.close
				twitter = page_html.css("a.twitter").text
				facebook =  page_html.css("a.facebook").text
				en = File.readlines('names.txt')[1].gsub(/\s/, '')
				ko = File.readlines('names.txt')[3].gsub(/\s/, '')
				csv << [en, ko, twitter, facebook]
			end
		sleep rand(5)
		end
	end
end