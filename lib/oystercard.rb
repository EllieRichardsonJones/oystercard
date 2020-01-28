class Oystercard

  MAXIMUM_BALANCE = 90 
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "you have reached your limit of #{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE

    @balance += amount
  end 

  def deduct(amount)
    
    @balance -= amount
  end
end
