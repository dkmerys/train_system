require 'spec_helper'

describe '#City' do
  
  before(:each) do 
    @train = Train.new({:name => "kiwi", :id => nil})
    @train.save
  end

  describe('initialize') do
    it ("creates a new city") do
      city = City.new({:name => 'portland', :train_id => @train.id, :id => nil})
      expect(city.name).to eq('portland')
    end
  end

  describe('.all') do
    it ("returns an empty array when there are no cities") do
      expect(City.all).to eq([])
    end
  end

  describe('#==') do
    it("is the same city if it shares the same attributes as another city") do
      city = City.new({:name => "Portland", :id => nil, :train_id => @train.id})
      city2 = City.new({:name => "Portland", :id => nil, :train_id => @train.id})
      expect(city).to(eq(city2))
    end
  end

  describe('#save') do
    it("saves a city") do
      city = City.new({:name => "Portland", :id => nil, :train_id => @train.id})
      city.save()
      expect(City.all).to(eq([city]))
    end
  end

end