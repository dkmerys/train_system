class Train
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains")
    trains = []
    returned_trains.each do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end
  
  def self.clear
    DB.exec("DELETE from trains *")
  end

  def save
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  
  def ==(train_to_compare)
    self.name == train_to_compare.name
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    name = train.fetch("name")
    id = train.fetch("id").to_i
    Train.new({:name => name, :id => id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete()
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

  def self.search(search_name)
    search_lower = search_name.downcase
    returned_trains = DB.exec("SELECT * FROM trains WHERE lower(name) LIKE '%#{search_lower}%';")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id")
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  # def cities
  #   City.find_by_train(self.id)
  # end

  
end