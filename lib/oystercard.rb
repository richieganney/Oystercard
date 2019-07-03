require 'pry'
require_relative 'station'
require_relative 'journey'

class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINUMUM_BALANCE = 1
  MINUMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :all_journeys, :one_journey

  def initialize
    @balance = DEFAULT_BALANCE
    @journey = nil
    @entry_station = nil
    @exit_station = nil
    @all_journeys = []
    @one_journey = {@entry_station => @exit_station}
  end

  def top_up(amount)
    raise("Maximum limit of #{MAXIMUM_BALANCE} exceded") if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
    puts "Topped up £#{amount}. New balance: £#{@balance}"
    return @balance
  end

  def touch_in(station)
    @balance < MINUMUM_BALANCE ? raise("Insufficient funds") : @journey = Journey.new
    @journey.start_journey
    @entry_station = station
    @one_journey = {station => @exit_station}
  end

  def touch_out(station)
    @exit_station = station
    deduct
    @one_journey[@entry_station] = station
    @all_journeys << @one_journey
    @journey.end_journey
    @journey.store_journey
    # @entry_station = nil
  end

  private

  def deduct
    @balance -= MINUMUM_CHARGE
  end

  # def in_journey?
  #   entry_station
  # end

  # def limit_exceded?
  #   @balance > 90
  # end

end

binding.pry
