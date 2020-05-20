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

  describe('#save') do
    it('saves a train') do
      train = Train.new({:name => 'kiwi', :id => nil})
      train.save()
      train2 = Train.new({:name => 'strawberry', :id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end


  describe('.find') do
    it('finds a train by id') do
      train = Train.new({:name => 'kiwi', :id => nil})
      train.save()
      train2 = Train.new({:name => 'strawberry', :id => nil})
      train2.save()
      expect(Train.find(train.id)).to eq(train)
    end
  end

  describe('.clear') do
    it("clears all albums") do
      train = Train.new({:name => 'kiwi', :id => nil})
      train.save()
      train2 = Train.new({:name => 'strawberry', :id => nil})
      train2.save()
      Train.clear()
      expect(Train.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train = Train.new({:name => 'kiwi', :id => nil})
      train2 = Train.new({:name => 'kiwi', :id => nil})
      expect(train).to(eq(train2))
    end
  end

  describe('#update') do
    it("updates a train by id") do
      train = Train.new({:name => 'kiwi', :id => nil})
      train.save
      train.update("strawberry")
      expect(train.name).to(eq("strawberry"))
    end
  end

  describe('#delete') do
    it("deletes a train") do
      train = Train.new({:name => 'kiwi', :id => nil})
      train.save
      train2 = Train.new({:name => 'strawberry', :id => nil})
      train2.save
      train.delete()
      expect(Train.all).to(eq([train2]))
    end
  end

  describe('.search') do
    it("will allow a user to search for a train") do
      train = Train.new({:name => 'kiwi', :id => nil})
      train.save
      train2 = Train.new({:name => 'strawberry', :id => nil})
      train2.save
      train3 = Train.new({:name => 'blueberry', :id => nil})
      train3.save
      expect(Train.search(train.name)).to(eq([train]))
      expect(Train.search("W")).to(eq([train, train2]))
      expect(Train.search("berry")).to(eq([train2, train3]))
    end
  end


end