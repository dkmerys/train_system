class Stop
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    # @train_id = attributes.fetch(:train_id)
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

  def delete
    DB.exec("DELETE FROM stops WHERE id = #{@id};")
  end

  def self.search(name)
    self.all.select{ | stop | stop.name.include?(name)}
  end

  def update(attributes)
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
      DB.exec("UPDATE stops SET name = '#{@name}' WHERE id = #{@id};")
    elsif (attributes.has_key?(:train_name)) && (attributes.fetch(:train_name) != nil)
      train_name = attributes.fetch(:train_name)
      train = DB.exec("SELECT * FROM trains WHERE lower(name)='#{train_name.downcase}';").first
      if train != nil
        DB.exec("INSERT INTO stops (train_id, city_id) VALUES (#{train['id'].to_i}, #{@id});")
      end
    end
  end

  def trains
    trains = []
    results = DB.exec("SELECT train_id FROM stops WHERE id = #{@id};")
    results.each do|result|
      binding.pry
        train_id = result.fetch("train_id").to_i
        train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
        name = train.first().fetch("name")
        trains.push(Train.new({:name => name, :id => train_id}))
    end
    trains
  end


end