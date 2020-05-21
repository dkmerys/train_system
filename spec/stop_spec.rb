require ('spec_helper')

describe ('#Stop') do

  describe('initialize') do
    it ("creates a new stop") do
     stop1 = Stop.new({:name => 'kiwi', :id => nil})
    expect(stop1.name).to eq('kiwi')
    end
  end

  describe('.all') do
    it ("returns an empty array when there are no stops") do
      expect(Stop.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same stop if it has the same attributes as another stop") do
      stop = Stop.new({:name => 'kiwi', :id => nil})
      stop2 = Stop.new({:name => 'kiwi', :id => nil})
      expect(stop).to(eq(stop2))
    end
  end

  describe('#save') do
    it("saves a new stop") do
      stop = Stop.new({:name => 'kiwi', :id => nil})
      stop.save()
      stop2 = Stop.new({:name => 'apple', :id => nil})
      stop2.save()
      expect(Stop.all).to(eq([stop, stop2]))
    end
  end

  describe('.clear') do
    it ("clears all trains") do
      stop = Stop.new({:name => 'kiwi', :id => nil})
      stop.save()
      stop2 = Stop.new({:name => 'apple', :id => nil})
      stop2.save()
      Stop.clear
      expect(Stop.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a stop by id") do
      stop = Stop.new({:name => 'kiwi', :id => nil})
      stop.save()
      stop2 = Stop.new({:name => 'apple', :id => nil})
      stop2.save()
      expect(Stop.find(stop.id)).to(eq(stop))
    end
  end

  describe('#delete') do
    it("deletes a stop") do
      stop = Stop.new({:name => 'kiwi', :id => nil})
      stop.save()
      stop2 = Stop.new({:name => 'apple', :id => nil})
      stop2.save()
      stop2.delete()
      expect(Stop.all).to(eq([stop]))
    end
  end

  describe('.search') do
    it('searches a stop by name') do
      stop = Stop.new({:name => 'kiwi', :id => nil})
      stop.save()
      stop2 = Stop.new({:name => 'apple', :id => nil})
      stop2.save()
      expect(Stop.search('kiwi')).to(eq([stop]))
    end
  end

  describe('#update') do
    it("adds a stop to a train") do
      stop = Stop.new({:name => 'kiwi', :id => nil})
      stop.save
      train = Train.new({:name => 'red line', :id => nil})
      train.save
      stop.update({:train_name => 'red line'})
      expect(stop.trains).to(eq([train]))
    end
  end
  
end