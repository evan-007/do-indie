task :import_db => :environment do
  require 'csv'
  en = 0 #value is the column in the .csv
  ko = 1
  twitter = 2
  facebook = 3
  CSV.foreach("#{Rails.root}"+"/lib/import.csv") do |row|
      Band.create(name: row[en], korean_name: row[ko], twitter: row[twitter], facebook: row[facebook])
  end
end