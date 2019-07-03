require 'station'

describe Station do
  
  it "creates a new instance of station" do
    station = double(:station)  
    allow(station).to receive(:name) { "Kings Cross" }
    allow(station).to receive(:zone) { 1 }
    expect(station.name).to eq "Kings Cross"
    expect(station.zone).to eq 1
  end

end