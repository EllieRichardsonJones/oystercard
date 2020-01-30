describe Oystercard do
  let(:entry_station){ double :station }  
  let(:exit_station){ double :station }
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

  it 'initializes with a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'is expects to be in journey' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(minimum_balance)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'should equal true when in journey' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(minimum_balance)
      expect { subject.touch_in(entry_station) }.to change{ subject.state }.to true
    end

    it 'raises an error if there is not enough money' do
        expect {subject.touch_in(entry_station)}.to raise_error "You do not have enough funds"
    end

    it 'stores the entry station' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(minimum_balance)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'should equal false when not in journey' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(minimum_balance)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.state }.to false
    end
    it 'should deduct the minimum fare' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by (-Oystercard::MINIMUM_CHARGE)
    end
  end

  describe '#top_up' do
    it 'adds money to the card' do
      minimum_balance = Oystercard::MINIMUM_BALANCE
      expect { subject.top_up(minimum_balance) }.to change{ subject.balance }.by minimum_balance
    end
    
    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      minimum_balance = Oystercard::MINIMUM_BALANCE
      subject.top_up(maximum_balance)
        expect {subject.top_up(minimum_balance)}.to raise_error "you have reached your limit of #{maximum_balance}"
    end
  end

  it 'stores an exit station' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  it 'has an empty list of journeys by default' do
    expect(subject.journeys).to be_empty
  end
  
  it 'stores a journey' do
    subject.top_up(Oystercard::MINIMUM_BALANCE)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end
end
