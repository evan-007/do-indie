task :import_artists => :environment do
  require 'csv'
  @ko = 0 #value is the column in the .csv
  @en = 1
  @label = 2
  @contact = 3
  @genre = 4
  @facebook = 5
  @twitter = 6
  @site = 7 
  @avatar = File.new("#{Rails.root}"+"/lib/scrape/"+"#{@ko}", "r")


  CSV.foreach("#{Rails.root}"+"/lib/scrape/band-info.csv") do |row|
      Band.create(name: row[@en], korean_name: row[@ko], 
        contact: row[@contact], genre: row[@genre], 
        twitter: row[@twitter], facebook: row[@facebook], 
        site: row[@site], avatar: @avatar, label: row[@label])
  end
end

task :import_venues => :environment do
	require 'csv'
	@name = 0
	@address = 1
	@area = 2
	CSV.foreach("#{Rails.root}"+"/lib/street-venues.csv") do |row|
		Venue.create(name: row[@name], address: row[@address], area: row[@area])
	end
end

