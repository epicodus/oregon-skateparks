require 'pg'

class City

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    cities = []
    results = DB.exec("SELECT * FROM cities;")
    results.each { |result| attributes = {id: result['id'].to_i, name: result['name']}; cities << City.new(attributes) }
    cities
  end

  def self.find(city_id)
    result = DB.exec("SELECT * FROM cities WHERE id = #{city_id};").first
    City.new({id: result['id'].to_i, name: result['name']})
  end

  def save
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def update(new_name)
    DB.exec("UPDATE cities SET name = '#{new_name}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{self.id};")
  end

  def ==(another_city)
    self.name == another_city.name
  end
end
