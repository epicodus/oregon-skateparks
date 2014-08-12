require 'pg'

class Feature

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id = attributes[:id]
  end

  def self.all
    features = []
    results = DB.exec("SELECT * FROM features;")
    results.each { |result| attributes = {id: result['id'].to_i, name: result['name']}; features << Feature.new(attributes) }
    features
  end

  def self.find(feature_id)
    result = DB.exec("SELECT * FROM features WHERE id = #{feature_id};").first
    Feature.new({id: result['id'].to_i, name: result['name']})
  end

  def save
    result = DB.exec("INSERT INTO features (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def update(new_name)
    DB.exec("UPDATE features SET name = '#{new_name}' WHERE id = #{self.id};")
  end

  def delete
    DB.exec("DELETE FROM features WHERE id = #{self.id};")
  end

  def ==(another_feature)
    self.name == another_feature.name
  end
end
