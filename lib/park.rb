require 'pg'

class Park

  attr_accessor :name, :id

  def initialize(attributes)
    @name = attributes[:name]
    @id
  end
end
