require 'pg'
require 'pry'

require './lib/city'
require './lib/feature'
require './lib/park'

DB = PG.connect({dbname: 'skateparks'})

def welcome
  system("clear")
  puts "OREGON SKATEPARKS"
  puts "================="
  menu
end

def menu
  input = nil
  until input == 'X'
    puts "Press 'H' if you're a hessian."
    puts "Press 'S' if you're a shredder."
    ws
    puts "Press 'X' to exit."
    case gets.chomp.upcase
    when 'H'
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
    list_parks
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

def add_park
  list_cities
  puts "Enter a city number from the list or press 'C' to add a new city:"
  input = gets.chomp
  case input
  when 'C'
    add_city
  else
    city = City.find(input)
    puts "Enter the name of the park:"
    binding.pry
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
    list_features
    puts "Enter a feature number from the list or press 'F' to add a new feature:"
    input = gets.chomp
    case input
    when 'F'
      add_feature
    else
      feature = Feature.find(input)
      list_parks
      puts "Enter a park number to assign #{feature.name} to:"
      park = Park.find(gets.chomp)
      park.assign_feature(feature)
      puts "Assigned #{park.feature.last.name} #{park.name}!"
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
  sleep 1
  admin_menu
end

def add_city
  list_cities
  puts "Enter a new city to add it to the list:"
  new_city = City.new(name: gets.chomp)
  new_city.save
  puts "#{new_city.name} added!"
  sleep 1
  admin_menu
end

def list_cities
  puts "Cities:"
  City.all.each {|city| puts "#{city.id}. #{city.name}"}
end

def list_features
  puts "Features:"
  Feature.all.each_with_index {|feature,index| "#{index + 1}. #{feature.name}"}
end

def list_parks
  puts "Parks"
  Park.all.each {|park| puts "#{park.id}. #{park.name}"}
end

def ws
  puts "\n"
end

welcome
