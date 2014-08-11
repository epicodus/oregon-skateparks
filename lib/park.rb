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

  def self.find(park_id)
    result = DB.exec("SELECT * FROM parks WHERE id = #{park_id};").first
    Park.new({id: result['id'].to_i, name: result['name']})
  end

  def save
    result = DB.exec("INSERT INTO parks (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def update(new_name)
    DB.exec("UPDATE parks SET name = '#{new_name}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM parks WHERE id = #{self.id};")
  end

  def ==(another_park)
    self.name == another_park.name
  end
end
