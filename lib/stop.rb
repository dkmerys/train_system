class Stop
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_stops = DB.exec("SELECT * FROM stops")
    stops = []
    returned_stops.each do |stop|
      name = stop.fetch("name")
      id = stop.fetch("id").to_i
      stops.push(Stop.new({:name => name, :id => id}))
    end
    stops
  end

  def save
    result = DB.exec("INSERT INTO stops (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(stop_to_compare)
    self.name == stop_to_compare.name
  end

  def self.clear
    DB.exec("DELETE FROM stops *;")
  end

  def self.find(id)
    stop = DB.exec("SELECT * FROM stops WHERE id = #{id};").first
    name = stop.fetch("name")
    id = stop.fetch("id").to_i
    Stop.new({:name => name, :id => id})
  end

end