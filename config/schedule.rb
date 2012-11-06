set :output, "log/whenever.log"

every 1.minutes do
  rake "epd"
end