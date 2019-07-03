class Journey

  attr_reader :stored_journeys

  def initialize
    @in_journey = false  
    @all_journeys = []
  end

  def start_journey
    @in_journey = true
  end

  def end_journey
    @in_journey = false
  end

  def store_journey
    @all_journeys << @journey
  end

end