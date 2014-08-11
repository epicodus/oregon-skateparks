require 'pg'

class Park

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    parks = []
    results = DB.exec("SELECT * FROM parks;")
    results.each { |result| attributes = {id: result['id'].to_i, name: result['name']}; parks << Park.new(attributes) }
    parks
  end

  def save
    result = DB.exec("INSERT INTO parks (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_park)
    self.name == another_park.name
  end
end
