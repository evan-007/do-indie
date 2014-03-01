task :import_artists => :environment do
  require 'csv'
  en = 0 #value is the column in the .csv
  ko = 1
  twitter = 2
  facebook = 3
  CSV.foreach("#{Rails.root}"+"/lib/import.csv") do |row|
      Band.create(name: row[en], korean_name: row[ko], twitter: row[twitter], facebook: row[facebook])
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