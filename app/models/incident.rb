class Incident < ActiveRecord::Base
  attr_accessible :police_response_raw, :incident_description, :ofc, :received_raw, :disp, :location_raw, :event_number, :cad_id, :priority_raw, :case_number, :location, :received, :priority, :police_response
  
  validates :cad_id, :uniqueness => true
  
  geocoded_by :location
  after_validation :geocode, :if => :location_changed?
end
