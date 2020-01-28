class Oystercard

  MAXIMUM_BALANCE = 90 
  attr_reader :balance
  attr_accessor :state

  def initialize
    @balance = 0
    @state = false
  end

  def top_up(amount)
    fail "you have reached your limit of #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end 

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @state
  end

  def touch_in
    @state = true
  end

  def touch_out
    @state = false
  end
end
