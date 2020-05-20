require ('spec_helper')

describe ('#Train') do
  
  describe('initialize') do
    it ("creates a new train") do
      train1 = Train.new({:name => 'kiwi', :id => nil})
      expect(train1.name).to eq('kiwi')
    end
  end

  describe ('.all') do
    it ("returns an empty array when there are no trains") do
      expect(Train.all).to eq([])
    end
  end



end