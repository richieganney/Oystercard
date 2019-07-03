require 'pry'
require_relative 'station'
require_relative 'journey'

class Oystercard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINUMUM_BALANCE = 1
  MINUMUM_CHARGE = 1
  PENALTY_CHARGE = 6

  attr_reader :balance, :entry_station, :exit_station, :all_journeys, :one_journey

  def initialize(journey = Journey.new)
    @balance = DEFAULT_BALANCE
    @journey = journey
    @all_journeys = @journey.all_journeys
    #@journey.all_journeys
    @entry_station = nil
    @exit_station = nil
    @one_journey = {}
  end

  def top_up(amount)
    raise("Maximum limit of #{MAXIMUM_BALANCE} exceded") if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
    puts "Topped up £#{amount}. New balance: £#{@balance}"
    return @balance
  end

  def touch_in(station)
    charge_penalty if @journey.in_journey == true 
    @balance < MINUMUM_BALANCE ? raise("Insufficient funds") : @journey.start_journey
    @entry_station = station
    # @one_journey = {station => @exit_station}
    #@one_journey << @entry_station.name
    #@one_journey << @entry_station.zone
  end

  def touch_out(station)
    if @journey.in_journey == false
      charge_penalty
    else
      @exit_station = station
      deduct_minimum_fare
      @one_journey[@entry_station] = station
      @all_journeys << @one_journey
      #@journey.all_journeys << { entry_station_name: @entry_station.station, entry_station_zone: @entry_station.zone, exit_station_name: @exit_station.station, exit_station_zone: @exit_station.zone }
      @journey.end_journey
      @journey = Journey.new
      @entry_station = nil
      @exit_station = nil
    end
  end

  def journey_reader
    @journey
  end

  private

  def deduct_minimum_fare
    @balance -= MINUMUM_CHARGE
  end

  def charge_penalty
    @balance -= PENALTY_CHARGE
  end

  # def in_journey?
  #   entry_station
  # end

  # def limit_exceded?
  #   @balance > 90
  # end

end

binding.pry
