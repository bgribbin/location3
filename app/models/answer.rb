class Answer < ActiveRecord::Base
attr_accessible :coords

require File.expand_path('config/environment', '.')

belongs_to :region


def self.loadanswer
	path = File.join(Rails.root, 'lib/tasks/text.txt')
	::File.open(path) do |file|
		file.each do |line|
            point = Region::GEOFACTORY.parse_wkt(line.strip)
            Answer.create(:coords => point.projection) if point
        end
    end
end

def self.find_region
    region = Region.where{st_contains(poly, Answer.first.coords)}.first
    region.region



end



end
