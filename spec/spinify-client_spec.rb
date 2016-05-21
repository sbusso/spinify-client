require 'spec_helper'

describe Spinify::Client do

  subject { Spinify::Client.new('','')}

  # Spinify::Client.stub(:get) { #forbidden }

  it { is_expected.to respond_to(:multi) }

  it { is_expected.to respond_to(:get) }

  it "should not be authorized without a proper key" do
    VCR.use_cassette('api') do
      expect(Spinify::Client.new('','').get.code).to eq(403)
    end
  end

  it "should be authorized with a proper auth and no vars" do
    WebMock.allow_net_connect!
    VCR.turned_off  do
      c = Spinify::Client.new('46f9e84117c024db0084a303','3uivo8DEDxgvaYrUF4SFzA', 'http://localhost:3000')
      expect(c.get.code).to eq(406)
    end
    WebMock.disable_net_connect!
  end

  it "should be authorized with a proper auth" do
    WebMock.allow_net_connect!
    VCR.turned_off  do
      c = Spinify::Client.new('46f9e84117c024db0084a303','3uivo8DEDxgvaYrUF4SFzA', 'http://localhost:3000')
      vars = {jockey: 'Soumillon', HF: false, trainer: "JP Viel"}
      expect(c.set(formula: "{{>forme_positive}}", category_id: 'c0e78bc84ff0c5539b931d39' ).variables(vars).get.code).to eq(200)
    end
    WebMock.disable_net_connect!
  end

end
