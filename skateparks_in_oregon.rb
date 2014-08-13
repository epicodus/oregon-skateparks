require 'pg'
require 'pry'

require './lib/city'
require './lib/feature'
require './lib/park'

DB = PG.connect({dbname: 'skateparks'})

def menu
  system("clear")
  puts "OREGON SKATEPARKS"
  puts "================="
  input = nil
  until input == 'X'
    puts "Press 'H' if you're a hessian."
    puts "Press 'S' if you're a shredder."
    ws
    puts "Press 'X' to exit."
    case gets.chomp.upcase
    when 'H'
      system("clear")
      admin_menu
    when 'S'
      user_menu
    when 'X'
      exit
    end
  end
end

def admin_menu
  system("clear")
  puts "HESSIANS"
  puts "========"
  if City.all == [] and Park.all == []
    add_park
  else
    puts "L > List all skateparks"
    puts "S > Add a skatepark"
    puts "F > Add a feature to a skatepark"
    ws
    puts "M > Return to main menu"
  end
  case gets.chomp.upcase
  when 'L'
    detail_view
    admin_menu
  when 'S'
    add_park
  when 'F'
    assign_feature
  when 'M'
    menu
  else
    puts "Bummer input, dude. Try again."
  end
end

def user_menu
  system("clear")
  puts "SHREDDERS"
  puts "========="

  puts "L > List all skateparks"
  puts "C > List skateparks by city"
  puts "F > List skateparks by feature"
  ws
  puts "M > Return to main menu"

  case gets.chomp.upcase
  when 'L'
    detail_view
    user_menu
  when 'C'
    parks_by_city
    user_menu
  when 'F'
    parks_by_feature
    user_menu
  when 'M'
    menu
  else
    puts "Bummer input, dude. Try again."
  end
end

def add_park
  system("clear")
  list_cities
  puts "Enter a city number from the list or press 'C' to add a new city:"
  input = gets.chomp
  case input
  when 'C'
    add_city
  else
    city = City.find(input)
    puts "Enter the name of the park to add to #{city.name}:"
    new_park = Park.new({name: gets.chomp, city_id: city.id})
    new_park.save
    puts "#{new_park.name} in #{city.name} added!"
    sleep 1
    admin_menu
  end
end

def assign_feature
  list_parks
  puts "Enter a park number from the list or press 'P' to add a new park:"
  input = gets.chomp
  case input
  when 'P'
    add_park
  else
    current_park = Park.find(input)
    list_features
    puts "Enter a feature number from the list or press 'F' to add a new feature:"
    input = gets.chomp
    case input
    when 'F'
      add_feature
    else
      feature = Feature.find(input)
      list_parks
      current_park.assign_feature(feature)
      puts "Assigned #{current_park.features.last.name} #{current_park.name}!"
      sleep 1
      admin_menu
    end
  end
end

def add_feature
  list_features
  puts "Enter a new feature to add it to the list:"
  new_feature = Feature.new(name: gets.chomp)
  new_feature.save
  puts "#{new_feature.name} added!"
  ws
  sleep 1
  admin_menu
end

def add_city
  system("clear")
  list_cities
  puts "Enter a new city to add it to the list:"
  new_city = City.new(name: gets.chomp)
  new_city.save
  puts "#{new_city.name} added!"
  ws
  sleep 1
  admin_menu
end

def list_cities
  puts "Cities:"
  City.all.each {|city| puts "#{city.id}. #{city.name}"}
  ws
end

def list_features
  puts "Features:"
  Feature.all.each {|feature| puts "#{feature.id}. #{feature.name}"}
  ws
end

def list_parks
  puts "Parks"
  Park.all.each {|park| puts "#{park.id}. #{park.name}"}
  ws
end

def parks_by_city
  puts "Enter a city's number to view its skateparks:"
  list_cities
  city = gets.chomp
  parks = Park.find_by_city(city)
  city_name = City.find(city).name
  system("clear")
  puts city_name.upcase
  puts "="*city_name.length
  puts "Parks"
  puts "-----"
  parks.each {|park| puts "  --#{park.name}"}
  continue
end

def parks_by_feature
  puts "Enter a feature's number to view its skateparks:"
  list_features
  feature = gets.chomp
  features = Park.find_by_feature(feature)
  feature_name = Feature.find(feature).name
  system("clear")
  puts feature_name.upcase
  puts "="*feature_name.length
  puts "Parks"
  puts "-----"
  features.each {|feature| puts "  --#{feature.name}"}
  continue
end

def detail_view
  system("clear")
  puts "PARKS"
  puts "====="
  Park.all.each do |park|
    puts "#{park.name}"
    puts "-"*park.name.length
    city = City.find(park.city_id)
    puts "Location: #{city.name}"
    puts "Features:"
    park.features.each do |feature|
      puts "  --#{feature.name}"
    end
    ws
  end
  continue
end

def ws
  puts "\n"
end

def continue
  ws
  puts "Press any key to continue"
  gets.chomp
end

menu
