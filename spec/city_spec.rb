require 'spec_helper'

describe City do
  describe "initialize" do
    it "initializes a new City object with a hash of attributes" do
      portland = City.new({name: "Portland"})
      expect(portland).to be_a City
      expect(portland.name).to eq "Portland"
    end
  end

  describe "save" do
    it "saves the City to the database" do
      portland = City.new({name: "Portland"})
      portland.save
      expect(City.all).to eq [portland]
    end
  end

  describe ".all" do
    it "returns all entries in the cities database" do
      portland = City.new({name: "Portland"})
      portland.save
      expect(City.all).to eq [portland]
    end
  end

  describe "==" do
    it "makes two different City objects with the same name equal" do
      portland_old = City.new({name: "Portland"})
      portland_new = City.new({name: "Portland"})
      expect(portland_old).to eq portland_new
    end
  end

  describe "update" do
    it "updates the name of the City in the database" do
      portland = City.new({name: "Portland"})
      portland.save
      portland.update("Under the Bridge")
      expect(City.all[0].name).to eq "Under the Bridge"
    end
  end

  describe "delete" do
    it "deletes the City from the database" do
      portland = City.new({name: "Portland"})
      portland.save
      newberg = City.new({name: "Newberg"})
      newberg.save
      portland.delete
      expect(City.all).to eq [newberg]
    end
  end

  describe ".find" do
    it "returns a City object given the City's id from the database" do
      portland = City.new({name: "Portland"})
      portland.save
      newberg = City.new({name: "Newberg"})
      newberg.save
      expect(City.find(newberg.id)).to eq newberg
    end
  end
end
