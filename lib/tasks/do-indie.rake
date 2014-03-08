task :import_artists => :environment do
  require 'csv'
  @ko = 0 
  @genre = 2 
  @myspace = 4
  @en = 5
  @bandcamp = 6
  @contact = 7
  @cafe = 8
  @facebook = 9
  @itunes = 10
  @label = 11
  @soundcloud = 12
  @twitter = 13
  @youtube = 15
 


  CSV.foreach("#{Rails.root}"+"/lib/bands.csv") do |row|
      @ko = row[0].gsub(/[^\p{Hangul}]/, '')
      # en_desc = row[1].gsub(/<!--:ko-->(.*?)<!--:-->/m, '')  
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
        
        )

      a.save
  end
end

#first run automator to add .png to end of files! will error if no photo!
task :import_photos => :environment do
  @bands = Band.all
  @bands.each do |band|
    file = File.open("#{Rails.root}"+"/public/images/bands/#{band.name}.png")
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

