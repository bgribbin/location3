class Region < ActiveRecord::Base
attr_accessible :poly, :name, :region

has_many :answers

  GEOFACTORY = RGeo::Geographic.simple_mercator_factory
    set_rgeo_factory_for_column(:poly, GEOFACTORY.projection_factory)

 
def self.load
	
    path = File.join(Rails.root, 'lib/tasks/uk/editable')
    factory = GEOFACTORY
	RGeo::Shapefile::Reader::open(path, :factory => factory) do |file|
		file.each do |record|
			name = record['name']
			map_region = record['region']
			region = Region.where(:name => name).first ||
			 record.geometry.projection.each do |poly|
			 Region.create(:name => name, :region => map_region, :poly => poly)
                
			end
		end
	end
end

def self.look
	
    path = File.join(Rails.root, 'lib/tasks/uk/editable')
	factory = Region::GEOFACTORY
	RGeo::Shapefile::Reader::open(path) do |file|
		file.each do |record|
			puts record['NAME']
			puts record.inspect
			
		end
	end
end

def self.find_region(lat, long)
	point = Region::GEOFACTORY.point(lat, long).projection
	region = Region.where{st_contains(poly, point)}.first

end




end
