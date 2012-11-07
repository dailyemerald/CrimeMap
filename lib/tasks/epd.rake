desc "Get EPD police log"

task :epd => :environment do

  require 'nokogiri'
  require 'open-uri'

  url = 'http://ceapps.eugene-or.gov/epdpubliccad/'
  #url = 'http://ceapps.eugene-or.gov/epdpubliccad/cadday.aspx?date=11/06/2012'
  page = Nokogiri::HTML(open(url))

  def rebuild_epd_date(weird_date_string)
    begin
      date_pieces = weird_date_string.split("/")
      date_string = [date_pieces[1], date_pieces[0], date_pieces[2]].join("-")
      return DateTime.parse( date_string )
    rescue
      return nil
    end
  end

  def commit_data_point(data_point)
    
    if data_point.length < 10
      puts "Rejected, too short. Probably a meta entry.", data_point.inspect, data_point.length
      return
    end
    
    if data_point[0][0].nil? #sometimes a nil sneaks in to the first spot to mess up the indexing
      data_point.shift
    end  
    
    #puts data_point.inspect
    
    cleaned_data = Hash.new
    cleaned_data["police_response_raw"]  = data_point[0][1]
    cleaned_data["incident_description"] = data_point[1][1]
    cleaned_data["ofc"]                  = data_point[2][1]
    cleaned_data["received_raw"]         = data_point[3][1]
    cleaned_data["disp"]                 = data_point[4][1]
    cleaned_data["location_raw"]         = data_point[5][1]
    cleaned_data["event_number"]         = data_point[6][1]
    cleaned_data["cad_id"]               = data_point[7][1]
    cleaned_data["priority_raw"]         = data_point[8][1]
    cleaned_data["case_number"]          = data_point[9][1]
    
    cleaned_data["police_response"] = rebuild_epd_date(cleaned_data["police_response_raw"])
    cleaned_data["received"]        = rebuild_epd_date(cleaned_data["received_raw"])      

    puts "#{cleaned_data["received_raw"]} -> #{cleaned_data["received"]}"
        
    cleaned_data["priority"] = cleaned_data["priority_raw"].to_i
    
    cleaned_data["location"] = cleaned_data["location_raw"].gsub("&", " AND ")
    cleaned_data["location"] = cleaned_data["location"].gsub(", EUG", ", EUGENE")
    
    #puts cleaned_data.inspect
    
    @existing_incident = Incident.find_by_cad_id(cleaned_data["cad_id"]) #hopefully this is unique
    
    if @existing_incident
      if @existing_incident.update_attributes(cleaned_data)
        puts "Updated existing incident, cad_id: #{@existing_incident.cad_id}"
      else
        puts "Failed to update attrs for existing incident"
      end
    else
      @new_incident = Incident.new(cleaned_data)
      if @new_incident.save
        puts "Created new incident successfully, cad_id: #{@new_incident.cad_id}"
      else
        puts "FAILED CREATING NEW INCIDENT!!!"
      end
    end

  end

  # now the real work starts:

  data_point = []
  page.css("table:last-of-type td").each do |node| 
    unless node.attributes['colspan'].nil?
      if node.attributes['colspan'].value == '4' # this is the horizontal divider between entries, so reset when we see one.
        commit_data_point(data_point)
        sleep 1
        data_point = []
      end
    end
    # surely theres' a better way to do the following:
    exploded = node.text.split(":")
    _attr = exploded.shift
    _data = exploded.join(":").strip
    data_point << [_attr, _data]
    
    
  end
  
end