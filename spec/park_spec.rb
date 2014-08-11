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
end
