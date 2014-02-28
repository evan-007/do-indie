task :scrape_comp_artists => :environment do
  require 'nokogiri'
  require 'open-uri'
  # words = 0 #value is the column in the .csv
  # definitions = 1
  # CSV.foreach("#{Rails.root}"+"/lib/ngsl-utf8.csv") do |row|
  #     Word.create(name: row[words], definition: row[definitions])
  for n in 1..181 do
  	page = Nokogiri::HTML(open("http://indistreet.com/en/korea/artist?page=""#{n}"))
  	puts page.css('.thumbLink').count
  end
end

for n in 1..5 do
  	page = Nokogiri::HTML(open("http://indistreet.com/musician?page=""#{n}"))
  	puts page.css('title')
  end


for n in 1..2 do
    	page = Nokogiri::HTML(open("http://indistreet.com/"))
  	puts page.css('title').text
  end

    	page = Nokogiri::HTML(open("http://indistreet.com/"))
