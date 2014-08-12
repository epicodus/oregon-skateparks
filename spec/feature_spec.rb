require 'spec_helper'

describe Feature do
  describe "initialize" do
    it "initializes a new Feature object with a hash of attributes" do
      bowls = Feature.new({name: "Bowls"})
      expect(bowls).to be_a Feature
      expect(bowls.name).to eq "Bowls"
    end
  end

  describe "save" do
    it "saves the Feature to the database" do
      bowls = Feature.new({name: "Bowls"})
      bowls.save
      expect(Feature.all).to eq [bowls]
    end
  end

  describe ".all" do
    it "returns all entries in the Features database" do
      bowls = Feature.new({name: "Bowls"})
      bowls.save
      expect(Feature.all).to eq [bowls]
    end
  end

  describe "==" do
    it "makes two different Feature objects with the same name equal" do
      burnside_old = Feature.new({name: "Bowls"})
      burnside_new = Feature.new({name: "Bowls"})
      expect(burnside_old).to eq burnside_new
    end
  end

  describe "update" do
    it "updates the name of the Feature in the database" do
      bowls = Feature.new({name: "Bowls"})
      bowls.save
      bowls.update("Under the Bridge")
      expect(Feature.all[0].name).to eq "Under the Bridge"
    end
  end

  describe "delete" do
    it "deletes the Feature from the database" do
      bowls = Feature.new({name: "Bowls"})
      bowls.save
      stairs = Feature.new({name: "Stairs"})
      stairs.save
      bowls.delete
      expect(Feature.all).to eq [stairs]
    end
  end

  describe ".find" do
    it "returns a Feature object given the Feature's id from the database" do
      bowls = Feature.new({name: "Bowls"})
      bowls.save
      stairs = Feature.new({name: "Stairs"})
      stairs.save
      expect(Feature.find(stairs.id)).to eq stairs
    end
  end
end
