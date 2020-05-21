require ('spec_helper')

describe ('#Stop') do

  before(:each) do 
    @train = Train.new({:name => "kiwi", :id => nil})
    @train.save
    @city = City.new({:name => "portland", :id => nil})
    @city.save
  end

  describe('initialize') do
    it ("creates a new stop") do
     stop1 = Stop.new({:name => 'kiwi', :id => nil, :train_id => @train.id, :city_id => @city.id })
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
      stop1 = Stop.new({:name => 'kiwi', :id => nil, :train_id => @train.id, :city_id => @city.id })
      stop2 = Stop.new({:name => 'kiwi', :id => nil,:train_id => @train.id, :city_id => @city.id })
      expect(stop1).to(eq(stop2))
    end
  end

  describe('#save') do
    it("saves a new stop") do
      stop1 = Stop.new({:name => 'kiwi', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop1.save
      expect(Stop.all).to(eq([stop1]))
    end
  end

  describe('.clear') do
    it ("clears all trains") do
      stop1 = Stop.new({:name => 'kiwi', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop1.save
      Stop.clear
      expect(Stop.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a stop by id") do
      stop1 = Stop.new({:name => 'kiwi', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop1.save
      expect(Stop.find(stop1.id)).to(eq(stop1))
    end
  end

  describe('#delete') do
    it("deletes a stop") do
      stop1 = Stop.new({:name => 'kiwi', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop1.save
      stop2 = Stop.new({:name => 'apple', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop2.save
      stop1.delete
      expect(Stop.all).to(eq([stop2]))
    end
  end

  describe('.search') do
    it('searches a stop by name') do
      stop1 = Stop.new({:name => 'kiwi', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop1.save
      stop2 = Stop.new({:name => 'apple', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop2.save
      expect(Stop.search('kiwi')).to(eq([stop1]))
    end
  end

  describe('#update') do
    it("adds a stop to a train") do
      stop1 = Stop.new({:name => 'downtown', :id => nil, :train_id => @train.id, :city_id => @city.id})
      stop1.save
      train = Train.new({:name => "apple", :id => nil})
      train.save()
      stop1.update({:train_name => 'apple'})
      # binding.pry
      expect(stop1.trains).to(eq([@train]))
    end
  end
  
end