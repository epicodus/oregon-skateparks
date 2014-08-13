require 'pg'

class Park

  attr_accessor :name, :id, :city_id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
    @city_id = attributes[:city_id]
  end

  def self.all
    parks = []
    results = DB.exec("SELECT * FROM parks;")
    results.each { |result| attributes = {id: result['id'].to_i, name: result['name'], city_id: result['city_id'].to_i}; parks << Park.new(attributes) }
    parks
  end

  def self.find(park_id)
    result = DB.exec("SELECT * FROM parks WHERE id = #{park_id};").first
    Park.new({id: result['id'].to_i, name: result['name']})
  end

  def self.find_by_city(city_id)
    parks = []
    results = DB.exec("SELECT * FROM parks WHERE city_id = #{city_id};")
    results.each do |result|
      attributes = {id: result['id'].to_i, name: result['name'], city_id: result['city_id'].to_i}
      parks << Park.new(attributes)
    end
    parks
  end

  def self.find_by_feature(feature_id)
    parks = []
    results = DB.exec("SELECT parks.* FROM features JOIN features_parks ON (features.id = features_parks.feature_id) JOIN parks ON (features_parks.park_id = parks.id) WHERE features.id = #{feature_id};")
    results.each do |result|
      attributes = {id: result['id'].to_i, name: result['name'], city_id: result['city_id'].to_i}
      parks << Park.new(attributes)
    end
    parks
  end

  def save
    result = DB.exec("INSERT INTO parks (name, city_id) VALUES ('#{self.name}', #{self.city_id}) RETURNING id;")
    @id = result.first['id'].to_i
  end

  def update(new_name)
    DB.exec("UPDATE parks SET name = '#{new_name}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM parks WHERE id = #{self.id};")
  end

  def assign_feature(feature)
    DB.exec("INSERT INTO features_parks (feature_id, park_id) VALUES (#{feature.id}, #{self.id});")
  end

  def features
    features = []
    results = DB.exec("SELECT features.* FROM parks JOIN features_parks ON (parks.id = features_parks.park_id) JOIN features ON (features_parks.feature_id = features.id) WHERE parks.id = #{self.id};")
    results.each do |result|
      attributes = {id: result['id'].to_i, name: result['name']}
      features << Feature.new(attributes)
    end
    features
  end

  def ==(another_park)
    self.name == another_park.name
  end
end
