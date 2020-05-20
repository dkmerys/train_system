class City

  attr_accessor :name, :train_id
  attr_reader :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @train_id = attributes.fetch(:train_id)
    @id = attributes.fetch(:id)
  end

  def ==(city_to_compare)
    (self.name == city_to_compare.name()) && (self.train_id() == city_to_compare.train_id())
  end

  def self.all 
    returned_cities = DB.exec("SELECT * FROM cities")
    cities = []
    returned_cities.each do |city|
      name = city.fetch("name")
      train_id = city.fetch("train_id").to_i
      id = city.fetch("id").to_i
      cities.push(City.new({:name => name, :train_id => train_id, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (name, train_id) VALUES ('#{@name}', #{@train_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    name = city.fetch("name")
    train_id = city.fetch("train_id").to_i
    id = city.fetch("id").to_i
    City.new({:name => name, :train_id => train_id, :id => id})
  end

  def update(name, train_id)
    @name = name
    @train_id = train_id
    DB.exec("UPDATE cities SET name = '#{@name}', train_id = #{@train_id} WHERE id = #{@id};")
  end
  
end
    