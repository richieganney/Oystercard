class Journey

#   attr_reader :all_journeys

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

  def all_journeys
    @all_journeys
  end

  def in_journey
    @in_journey
  end

end