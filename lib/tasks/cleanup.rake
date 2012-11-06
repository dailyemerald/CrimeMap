desc "Cleanup incorrect entries by checking that cad_id is less than 10 chars long."

task :cleanup => :environment do
  Incident.all.each { |i| i.destroy unless i.cad_id.to_s.length < 10 }
end