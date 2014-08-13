require 'spec_helper'

describe Park do
  describe "initialize" do
    it "initializes a new park object with a hash of attributes" do
      burnside = Park.new({name: "Burnside"})
      expect(burnside).to be_a Park
      expect(burnside.name).to eq "Burnside"
    end
  end

  describe "save" do
    it "saves the park to the database" do
      burnside = Park.new({name: "Burnside"})
      burnside.save
      expect(Park.all).to eq [burnside]
    end
  end

  describe ".all" do
    it "returns all entries in the parks database" do
      burnside = Park.new({name: "Burnside"})
      burnside.save
      expect(Park.all).to eq [burnside]
    end
  end

  describe "==" do
    it "makes two different park objects with the same name equal" do
      burnside_old = Park.new({name: "Burnside"})
      burnside_new = Park.new({name: "Burnside"})
      expect(burnside_old).to eq burnside_new
    end
  end

  describe "update" do
    it "updates the name of the park in the database" do
      burnside = Park.new({name: "Burnside"})
      burnside.save
      burnside.update("Under the Bridge")
      expect(Park.all[0].name).to eq "Under the Bridge"
    end
  end

  describe "delete" do
    it "deletes the park from the database" do
      burnside = Park.new({name: "Burnside"})
      burnside.save
      newberg = Park.new({name: "Newberg"})
      newberg.save
      burnside.delete
      expect(Park.all).to eq [newberg]
    end
  end

  describe ".find" do
    it "returns a park object given the park's id from the database" do
      burnside = Park.new({name: "Burnside"})
      burnside.save
      newberg = Park.new({name: "Newberg"})
      newberg.save
      expect(Park.find(newberg.id)).to eq newberg
    end
  end

  describe "assign_feature" do
    it "assigns a feature to the park" do
      burnside = Park.new({name: "Burnside"})
      burnside.save
      bowls = Feature.new({name: "Bowls"})
      bowls.save
      burnside.assign_feature(bowls)
      expect(burnside.features).to eq [bowls]
    end
  end

  describe "features" do
    it "returns the features of a given park" do
      burnside = Park.new({name: "Burnside"})
      burnside.save
      bowls = Feature.new({name: "Bowls"})
      bowls.save
      stairs = Feature.new({name: "Stairs"})
      stairs.save
      burnside.assign_feature(bowls)
      burnside.assign_feature(stairs)
      expect(burnside.features).to eq [bowls, stairs]
    end
  end
end
