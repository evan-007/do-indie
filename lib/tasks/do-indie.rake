task :import_artists => :environment do
  require 'csv'
  @ko = 0 
  @genre = 2 
  @photo_url = 3
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
        photo_url: row[@photo_url]
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

task :heroku_import_photos => :environment do
  #URI errors: assassination squad, eunsu lee, Say Sue Me.png, Kuang Program, Dead Buttons, Angry Bear
  # So Long, Buffalo | Jake & the Slut | PLASTIC HEART | Morrison Hotel | Yamagata Tweakster
  #fix by editing band name to match filename via copy paste, wtf?
  #seems related to either caps or spaces in file names
  #use IDS instead of names?
  @bands = Band.all
  @bands.each do |band|
    band.avatar = "http://do-indie.s3.amazonaws.com/bands/raw/#{band.id}.png"
    band.save!
  end
end

task :import_venues => :environment do
	require 'csv'
  @cafe = 2
  @email = 3
  @facebook = 4
  @phone = 5
  @twitter = 6
  @website = 7
	@address = 8
	
  
  


	CSV.foreach("#{Rails.root}"+"/lib/wp-venues.csv") do |row|
    @name = row[0].gsub(/[^\p{Hangul}]/, '')
    @en_name = row[0].gsub(/<!--:ko-->(.*?)<!--:-->|<!--:en-->|<!--:-->/, '')
    @city_ko = row[1].gsub(/[^\p{Hangul}]/, '')
    @city_en = /\w+/.match(row[1]).to_s.capitalize
		Venue.create(name: @en_name,
      korean_name: @name,
      city_en: @city_en,
      city_ko: @city_ko,
      cafe: row[@cafe],
      email: row[@email],
      facebook: row[@facebook],
      phone: row[@phone],
      twitter: row[@twitter],
      website: row[@website],
      address: row[@address]
      )
	end
end

task :import_venue_data => :environment do
  #be sure CSV fields all have data!
  CSV.foreach("#{Rails.root}"+"/lib/venue-data.csv", headers: true) do |row|
    @text = row[1].gsub(/<!--:ko-->|<!--:en-->|<!--:-->|[a-zA-Z]|<\/>|<div>|<\/div>|<span>|<\/span>/, '')
    @name = row[0].gsub(/<!--:ko-->(.*?)<!--:-->|<!--:en-->|<!--:-->/, '')
    a = Venue.find_by(name: @name)
    a.update(misc: @text)
  end
end

task :import_venue_photos => :environment do
  @venues = Venue.all
  @venues.each do |venue|
    file = File.open("http://do-indie.s3.amazonaws.com/bands/raw/#{venue.name}.png")
    venue.avatar = file
    file.close
    venue.save!
  end
end

#only needed to get photos from WP site
task :photo_dump => :environment do
  require 'open-uri'
  require 'net/https'
  require 'uri'
  @bands = Band.all
  @bands.each do |band|
    raw_url = "http://doindie.staging.wpengine.com/wp-content/uploads/#{band.photo_url}"
    escape_url = URI.escape raw_url #deals with korean characters breaking everything
    url = URI.parse(escape_url)
    Net::HTTP.start(url.host, url.port) do |http|
      @id = band.id
      req = Net::HTTP.new(url.host, url.port)
      res = req.request_head(url.path)
      resd = http.get(url.request_uri)
      open("#{@id}.png", "wb") do |f|
        f.write(resd.body)
      end
    end
  end
end