class Oystercard

  MAXIMUM_BALANCE = 90 
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  attr_reader :balance, :entry_station, :exit_station
  attr_accessor :state, :journeys

  def initialize
    @balance = 0
    @state = false
    @entry_station = nil
    @journeys = []
    @exit_station = nil
  end

  def top_up(amount)
    fail "you have reached your limit of #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end 

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    fail "You do not have enough funds" if @balance < MINIMUM_BALANCE
    @state = true
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @entry_station
    @state = false
    @exit_station = station
    @journeys << {entry_station: @entry_station, exit_station: @exit_station}
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
