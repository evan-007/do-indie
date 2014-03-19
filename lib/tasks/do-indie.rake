task :import_artists => :environment do
  require 'csv'
  @ko = 0 
  @genre = 4 
  @photo_url = 5
  @myspace = 6
  @en = 8
  @bandcamp = 9
  @contact = 10
  @cafe = 11
  @facebook = 12
  @itunes = 13
  @label = 14
  @soundcloud = 15
  @twitter = 16
  @youtube = 18
  @bio = 1
 
  CSV.foreach("#{Rails.root}"+"/lib/bands-raw-2.csv", headers: true) do |row|
      @ko = row[0].gsub(/[^\p{Hangul}]/, '')
      unless row[@bio] == nil
        @en_bio = row[@bio].gsub(/^[^_]*<!--:en-->|<!--:-->/, '')
        @ko_bio = row[@bio].match(/^[^_]*<!--:en-->|<!--:-->/).to_s.gsub(/<!--:ko-->|<!--:-->|<!--:en-->/, '')
      end  
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
        photo_url: row[@photo_url],
        en_bio: @en_bio,
        ko_bio: @ko_bio
        )

      a.save
  end
end

#run following 3 tasks in succession!
task :band_categories => :environment do
  #crude, only gets last category
  @bands = Band.all
  @bands.each do |band|
    unless band.genre == nil
      band.update(genre: band.genre.gsub(/^[^_]*:/, ''))
    end
  end
end

task :build_genres => :environment do
  #create genre entries
  @bands = Band.all
  @bands.each do |band|
    unless band.genre == nil
      if Genre.where(name: band.genre) == []
        Genre.create(name: band.genre)
      end
    end
  end
end

task :seed_genres => :environment do
  #build the relationships
  @bands = Band.all
  @bands.each do |band| 
    unless band.genre == nil
      band.band_genres.create(genre_id: (Genre.find_by(name: band.genre).id))
    end
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
  #this will work until the CSV used to import is changed.
  @bands = Band.all
  @bands.each do |band|
    band.avatar = "http://do-indie.s3.amazonaws.com/bands/raw/#{band.id}.png"
    band.save!
  end
end

task :import_venues => :environment do
	require 'csv'
  @cafe = 7
  @email = 9
  @facebook = 10
  @phone = 11
  @twitter = 12
  @website = 13
	@address = 14
  @lat = 16
  @long = 17
  @map = 6
	
  
  

	CSV.foreach("#{Rails.root}"+"/lib/venue-data.csv", headers: true) do |row|
    @name = row[0].gsub(/[^\p{Hangul}]/, '')
    @en_name = row[0].gsub(/<!--:ko-->(.*?)<!--:-->|<!--:en-->|<!--:-->/, '')
    unless row[4] == nil
      @city_ko = row[4].gsub(/[^\p{Hangul}]/, '')
      @city_en = /\w+/.match(row[4]).to_s.capitalize    
    end
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
      address: row[@address],
      small_map: row[@map]
      )
    Venue.last.update(latitude: row[@lat], longitude: row[@long])
	end
end

task :import_venue_data => :environment do
  #be sure CSV fields all have data!
  CSV.foreach("#{Rails.root}"+"/lib/venue-data.csv", headers: true) do |row|
    @ko_text = row[1].match(/^[^_]*<!--:en-->|<!--:-->/).to_s.gsub(/<!--:ko-->|<!--:-->|<!--:en-->/, '')
    @name = row[0].gsub(/<!--:ko-->(.*?)<!--:-->|<!--:en-->|<!--:-->/, '')
    @en_text = row[1].gsub(/^[^_]*<!--:en-->|<!--:-->/, '')
    if row[8] != nil
      @en_directions = row[8].gsub(/^[^_]*<!--:en-->|<!--:-->/, '')
      @ko_directions = row[8].gsub(/<!--:ko-->|<!--:en-->|<!--:-->|[a-zA-Z]|<\/>|<div>|<\/div>|<span>|<\/span>/, '')
    end
    a = Venue.find_by(name: @name)
    a.update(ko_bio: @ko_text)
    a.update(en_bio: @en_text)
    a.update(en_directions: @en_directions)
    a.update(ko_directions: @ko_directions)
  end
end

task :import_venue_photos => :environment do
  require 'uri'
  require 'net/https'
  @venues = Venue.all
  @venues.each do |venue|
    puts venue.id
    raw_url = "http://do-indie.s3.amazonaws.com/venues/raw/#{venue.name}.png"
    escape_url = URI.escape raw_url
    venue.avatar = escape_url
    venue.save!
  end
end

task :import_venue_maps => :environment do
  require 'uri'
  require 'net/https'
  @venues = Venue.all
  @venues.each do |venue|
    unless venue.small_map == nil
      url = "http://do-indie.s3.amazonaws.com/venues/map_raw/#{venue.id}.png"
      venue.minimap = url
      venue.save!
    end
  end
end

task :seed_cities => :environment do
  @venues = Venue.all
  @venues.each do |venue|
    unless venue.city_en == nil && venue.city_ko == nil
      City.create(en_name: venue.city_en, ko_name: venue.city_ko)
    end
  end
end

task :venue_cities => :environment do
  @venues = Venue.all
  @venues.each do |venue|
    unless venue.city_en == nil && venue.city_ko == nil
      venue.venue_cities.create(city_id: City.find_by(en_name: venue.city_en).id)
    end
  end
end

task :venue_map_dump => :environment do
  require 'open-uri'
  require 'net/https'
  require 'uri'
  @venues = Venue.all
  @venues.each do |venue|
    if venue.small_map != nil
      puts venue.name
      raw_url = venue.small_map
      escape_url = URI.escape raw_url #deals with korean characters breaking everything
      url = URI.parse(escape_url)
      Net::HTTP.start(url.host, url.port) do |http|
        @id = venue.id
        req = Net::HTTP.new(url.host, url.port)
        res = req.request_head(url.path)
        resd = http.get(url.request_uri)
        open("#{@id}.png", "wb") do |f|
          f.write(resd.body)
        end
      end
    end
  end
end

task :friendly_id => :environment do
  Band.find_each(&:save)
  Venue.find_each(&:save)
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

#for heroku and ckeditor
namespace :ckeditor do
  desc 'Create nondigest versions of some ckeditor assets (e.g. moono skin png)'
  task :create_nondigest_assets do
    fingerprint = /\-[0-9a-f]{32}\./
    for file in Dir['public/assets/ckeditor/contents-*.css', 'public/assets/ckeditor/skins/moono/*.png']
      next unless file =~ fingerprint
      nondigest = file.sub fingerprint, '.' # contents-0d8ffa186a00f5063461bc0ba0d96087.css => contents.css
      FileUtils.cp file, nondigest, verbose: true
    end
  end
end

