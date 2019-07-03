require 'journey'

describe Journey do

  describe '#start_journey' do
    it 'commencess a journey' do
        expect(subject.start_journey).to eq true
    end
  end

end