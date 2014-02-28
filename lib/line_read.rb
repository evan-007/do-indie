require 'rio'

#returns the names of band, english then korean
puts File.readlines('names.txt')[1].gsub(/\s/, '')
puts File.readlines('names.txt')[3].gsub(/\s/, '')

# name = rio('names.txt').lines[1].to_s.gsub(/\s/, '')
# puts name
# .to_s.gsub("\n", '')

# File.open('names.txt', 'r') do |file|
# 	while line = file.gets
# 		line.gsub!(/\s/, '')
# 		puts rio('names.txt')
# 	end	
	# name = (/\w/).match(rio('names.txt').lines[1].to_s)
	# puts name
# end

