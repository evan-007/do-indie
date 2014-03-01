require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'watir'
require 'csv'
require 'yaml'
require 'rio'

@counter = YAML.load_file("counter.yaml")

@range = 500

File.open("counter.yaml" , "w+") {|f| YAML.dump(@counter, f)}

links = rio("list.txt").lines[@counter+1..@counter+@range].map { |line| line.split[0] }

browser = Watir::Browser.start "http://indistreet.com/en/korea/artist?page=1"


links.each { |link|
	browser.goto ("http://indistreet.com""#{link}")
	@counter = YAML.load_file("counter.yaml")
	page_html = Nokogiri::HTML.parse(browser.html)
	File.open('names.txt', 'w') do |file2|
		file2.puts page_html.css('.name')[0].text
		file2.close
		twitter = page_html.css("a.twitter").text
		facebook =  page_html.css("a.facebook").text
		en = File.readlines('names.txt')[1].gsub(/\s/, '')
		ko = File.readlines('names.txt')[3].gsub(/\s/, '')
		CSV.open("data.csv", "a+") do |csv|
			csv << [en, ko, twitter, facebook]
		end
	end
sleep rand(5)
File.open("counter.yaml" , "w+") {|f| YAML.dump(@counter+1, f)}
puts @counter
}
