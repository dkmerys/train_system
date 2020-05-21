require 'spec_helper'

describe '#City' do
  

  describe('initialize') do
    it ("creates a new city") do
      city = City.new({:name => 'portland', :id => nil})
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
      city = City.new({:name => "Portland", :id => nil})
      city2 = City.new({:name => "Portland", :id => nil})
      expect(city).to(eq(city2))
    end
  end

  describe('#save') do
    it("saves a city") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      expect(City.all).to(eq([city]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      city2 = City.new({:name => "Kansas City", :id => nil})
      city2.save()
      City.clear
      expect(City.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds a city by id") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      city2 = City.new({:name => "Kansas City", :id => nil})
      city2.save()
      expect(City.find(city.id)).to(eq(city))
    end
  end

  describe('#update') do
    it("updates a city by id") do
      city = City.new({:name => "Portland", :id => nil,})
      city.save()
      city.update("Kansas City")
      expect(city.name).to eq("Kansas City")
    end
  end

  describe('#delete') do
    it("deletes a city by id") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      city2 = City.new({:name => "Kansas City", :id => nil})
      city2.save()
      city.delete()
      expect(City.all).to(eq([city2]))
    end
  end

  # describe('.find_by_train') do
  #   it("finds cities for a train") do
  #     train2 = Train.new({:name => "strawberry", :id => nil})
  #     train2.save
  #     city = City.new({:name => "Portland", :id => nil})
  #     city.save()
  #     city2 = City.new({:name => "Kansas City", :id => nil})
  #     city2.save()
  #     expect(City.find_by_train(train2.id)).to(eq([city2]))
  #   end
  # end

  # describe('#train') do
  #   it("finds the train a city belongs to") do
  #     city = City.new({:name => "Portland", :id => nil, :train_id => @train.id})
  #     city.save()
  #     expect(city.train()).to(eq(@train))
  #   end
  # end

end