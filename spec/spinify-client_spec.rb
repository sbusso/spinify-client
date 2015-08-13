require 'spec_helper'

describe Spinify::Client do

  subject { Spinify::Client.new('','')}

  # Spinify::Client.stub(:get) { #forbidden }

  it { is_expected.to respond_to(:multi) }

  it { is_expected.to respond_to(:get) }
  
  it "should not be authorized without a proper key" do
    VCR.use_cassette('api') do
      expect(Spinify::Client.new('','').get({}).code).to be(403)
    end
  end

  it "should chain methods"
end
