require 'journey'

describe Journey do

  describe '#start_journey' do
    it 'commencess a journey' do
        expect(subject.start_journey).to eq true
    end
  end

#   describe '#store_journey'
#   it 'stores all journeys' do
#     oystercard = double(:oystercard)
#     allow(oystercard).to receive(:top_up) { 5 }
#     allow(oystercard).to receive(:touch_in) {}

  describe '#fare' do
    it 'returns the minimum fare' do
        expect(subject.fare).to eq 1
    end
  end


end
