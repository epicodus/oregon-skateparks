require 'pg'
require 'rspec'

require 'city'
require 'feature'
require 'park'

DB = PG.connect({dbname: 'skateparks_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM features *;")
    DB.exec("DELETE FROM parks *;")
    DB.exec("DELETE FROM parks_features *;")
  end
end

