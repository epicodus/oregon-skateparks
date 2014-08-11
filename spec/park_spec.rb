require 'spec_helper'

describe Park do
  describe "initialize" do
    it "initializes a new park object with a hash of attributes" do
      burnside = Park.new({name: "Burnside"})
      expect(burnside).to be_a Park
      expect(burnside.name).to eq "Burnside"
    end
  end
end
