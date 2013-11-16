require "rubygems"
require "open-uri"
require "nokogiri"
require 'net/http'
category="stripbooks"
search="batman"
page="2"
Amazon_Url="http://www.amazon.in/s/?url=search-alias%3D#{category}&field-keywords=#{search}&page=#{page}"
result=Nokogiri::HTML(open(Amazon_Url))
links=result.css("div.productTitle a")
links[1..3].each do |link|
  puts link['href']
  begin
    newResult=Nokogiri::HTML(open(link['href']))
  rescue Exception=>e
    puts "Error: #{e}"
    sleep 5
  else
    list=newResult.css("td.bucket div.content").css("ul li")
    list.each do |item|
      if item.content.match("Amazon*") or item.content.match("#") then
        next
      end
      puts item.text
      puts "\n"
    end
  ensure
    sleep 1.0 + rand
  end
end

