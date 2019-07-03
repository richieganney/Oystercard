require 'oystercard'

describe Oystercard do

  let(:station){ double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it "has an initial balance of £0" do
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe '#top_up' do
    it "Tops up the balance by a specified amount" do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end

    it "Tops up the balance by a specified amount" do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it 'raises an error if maximum limit (£90) is reached' do
      subject.top_up Oystercard::MAXIMUM_BALANCE
      expect{ subject.top_up 1 }.to raise_error("Maximum limit of #{Oystercard::MAXIMUM_BALANCE} exceded")
    end

    it 'allows you to top up to the maxumum limit' do
      expect(subject.top_up Oystercard::MAXIMUM_BALANCE).to eq subject.balance
    end
  end

  # describe '#deduct' do
  #   it "Deducts a spcified amount from the balane of the card" do
  #     subject.top_up 10
  #     expect{ subject.deduct(5) }.to change{ subject.balance }.by -5
  #   end
  # end

  describe '#touch_in' do
    it "Commences a journey" do
      subject.top_up 1
      expect(subject.touch_in("Kings Cross")).to eq ({"Kings Cross"=>nil})
    end

    it 'raises an error if there are insufficient funds' do
      expect{ subject.touch_in("Kings Cross") }.to raise_error("Insufficient funds")
    end

    it "allows a user to know where they've travelled from" do
      subject.top_up 5
      subject.touch_in("Kings Cross")
      expect(subject.entry_station).to eq "Kings Cross"
    end

    # it 'initializes a journey instance and sets an entry station' do
    #   station = double(:station)
    #   subject.top_up 5
    #   subject.touch_in(station)
    # end

  end

  # describe '#touch_out' do
  #   it "Ends a journey" do
  #     subject.top_up 5
  #     subject.touch_in("Kings Cross")
  #     subject.touch_out "Hammersmith"
  #     expect(subject.in_journey).to eq false
  #   end

  #   it 'deducts the fare from the balance (£1) after a journey' do
  #     subject.top_up 5
  #     subject.touch_in("Kings Cross")
  #     expect{ subject.touch_out station }.to change{ subject.balance }.by (-Oystercard::MINUMUM_CHARGE)
  #   end
  # end

  describe '#all_journeys' do
    it "stores all journeys" do
      subject.top_up 5
      subject.touch_in "Kings Cross"
      subject.touch_out "Hammersmith"
      expect(subject.all_journeys).to eq ([{"Kings Cross" => "Hammersmith"}])
    end
  end

end
