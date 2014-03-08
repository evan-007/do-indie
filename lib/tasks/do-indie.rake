task :import_artists => :environment do
  require 'csv'
  @ko = 0 
  @genre = 2 
  @myspace = 4
  @en = 6
  @bandcamp = 7
  @contact = 8
  @cafe = 9
  @facebook = 10
  @itunes = 11 
  @label = 12
  @soundcloud = 13
  @twitter = 14
  @youtube = 15
 


  CSV.foreach("#{Rails.root}"+"/lib/scrape/bands-no-header.csv") do |row|
      @ko = row[0].gsub(/[^\p{Hangul}]/, '')
      a = Band.create(korean_name: @ko, 
        genre: row[@genre],
        myspace: row[@myspace],
        name: row[@en],
        bandcamp: row[@bandcamp],
        contact: row[@contact],
        cafe: row[@cafe],
        facebook: row[@facebook],
        itunes: row[@itunes],
        label: row[@label],
        soundcloud: row[@soundcloud],
        twitter: row[@twitter], 
        youtube: row[@youtube], 
        site: row[@site],
        )

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

