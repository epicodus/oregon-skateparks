require 'spec_helper'

describe Feature do
  describe "initialize" do
    it "initializes a new Feature object with a hash of attributes" do
      burnside = Feature.new({name: "Burnside"})
      expect(burnside).to be_a Feature
      expect(burnside.name).to eq "Burnside"
    end
  end

  describe "save" do
    it "saves the Feature to the database" do
      burnside = Feature.new({name: "Burnside"})
      burnside.save
      expect(Feature.all).to eq [burnside]
    end
  end

  describe ".all" do
    it "returns all entries in the Features database" do
      burnside = Feature.new({name: "Burnside"})
      burnside.save
      expect(Feature.all).to eq [burnside]
    end
  end

  describe "==" do
    it "makes two different Feature objects with the same name equal" do
      burnside_old = Feature.new({name: "Burnside"})
      burnside_new = Feature.new({name: "Burnside"})
      expect(burnside_old).to eq burnside_new
    end
  end

  describe "update" do
    it "updates the name of the Feature in the database" do
      burnside = Feature.new({name: "Burnside"})
      burnside.save
      burnside.update("Under the Bridge")
      expect(Feature.all[0].name).to eq "Under the Bridge"
    end
  end

  describe "delete" do
    it "deletes the Feature from the database" do
      burnside = Feature.new({name: "Burnside"})
      burnside.save
      newberg = Feature.new({name: "Newberg"})
      newberg.save
      burnside.delete
      expect(Feature.all).to eq [newberg]
    end
  end

  describe ".find" do
    it "returns a Feature object given the Feature's id from the database" do
      burnside = Feature.new({name: "Burnside"})
      burnside.save
      newberg = Feature.new({name: "Newberg"})
      newberg.save
      expect(Feature.find(newberg.id)).to eq newberg
    end
  end
end
