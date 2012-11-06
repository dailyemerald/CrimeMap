class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      
      t.string :police_response_raw
      t.string :incident_description
      t.string :ofc
      t.string :received_raw
      t.string :disp
      t.string :location_raw
      t.string :event_number
      t.string :cad_id
      t.string :priority_raw
      t.string :case_number
      
      t.integer :priority
      t.datetime :police_response
      t.datetime :received
      t.string :location
      
      t.timestamps
    end
  end
end
