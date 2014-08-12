require 'pg'
require 'pry'

require './lib/city'
require './lib/feature'
require './lib/park'

DB = PG.connect({dbname: 'skateparks'})

def welcome
  puts "OREGON SKATEPARKS"
  puts "================="
  menu
end

def menu
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
  else
    puts "Bummer input, dude. Try again."
  end
end

def admin_menu
  if City.all == [] and Park.all == []
    add_skatepark
  else
    puts "C > Add a city"
    puts "S > Add a skatepark"
    puts "F > Add a feature to a skatepark"
    ws
    puts "M > Return to main menu"
  end

  case gets.chomp.upcase
  when 'C'
    add_city
  when 'S'
    add_skatepark
  when 'F'
    add_feature
  when 'M'
    menu
  else
    puts "Bummer input, dude. Try again."
  end
end

def add_skatepark
  puts "ADD A SKATEPARK"
  puts "==============="
  ws
  puts "Choose a city from the list or enter a new one:"
  ws
  City.all.each {|city| puts city.name}
  input = gets.chomp
  City.all.each do |city|
    if city.name == input
      new_city = city
    end
  end
  new_city = City.new(:name => gets.chomp)
  new_city.save
  ws
  puts "Enter the name of a skatepark in #{new_city.name}:"
  new_park = Park.new(:name => gets.chomp, :city_id => new_city.id)
  new_park.save
  ws
  puts "Sucessfully created #{new_park.name} in #{new_city.name}."
  ws
  admin_menu
end

def ws
  puts "\n"
end

welcome
