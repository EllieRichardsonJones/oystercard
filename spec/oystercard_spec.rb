describe Oystercard do
  it 'initializes with a default balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do 
    it 'adds money to the card' do
      expect { subject.top_up(30) }.to change{ subject.balance }.by 30
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE 
      subject.top_up(maximum_balance)
        expect {subject.top_up(1)}.to raise_error "you have reached your limit of #{maximum_balance}"
    end
  end

    describe '#deduct' do
      # it { is_expected.to respond_to(:deduct).with(1).argument }
      it 'deducts amount from card' do
        subject.top_up(20)
        expect { subject.deduct(3) }.to change{ subject.balance }.by -3
      end
    end
end 
