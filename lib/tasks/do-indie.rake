task :import_artists => :environment do
  require 'csv'
  @ko = 0 
  @en = 1
  @label = 2
  @contact = 3
  @genre = 4
  @facebook = 5
  @twitter = 6
  @site = 7 
 


  CSV.foreach("#{Rails.root}"+"/lib/scrape/band-info.csv") do |row|

      a = Band.create(name: row[@en], korean_name: row[@ko], 
        contact: row[@contact], genre: row[@genre], 
        twitter: row[@twitter], facebook: row[@facebook], 
        site: row[@site],
        label: row[@label])

      a.save
  end
end

#first run automator to add .png to end of files! will error if no photo!
task :import_photos => :environment do
  @bands = Band.all
  @bands.each do |band|
    file = File.open("#{Rails.root}"+"/public/images/bands/#{band.korean_name}.png")
    band.avatar = file
    file.close
    band.save!
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

