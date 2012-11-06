class Incident < ActiveRecord::Base
  
  validates :cad_id, :uniqueness => true

end
