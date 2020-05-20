require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require('./lib/city')
require('./lib/stop')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "train_system"})

get('/') do
  @trains = Train.all
  erb(:trains)
end

get('/trains') do
  @trains = Train.all
  erb(:trains)
end

get('/trains/new') do
  erb(:new_train)
end

get('/trains/:id') do
  @train = Train.find(params[:id])
  erb(:train)
end

get('/trains/:id/edit') do
  @train = Train.find(params[:id])
  erb(:edit_train)
end

post('/trains') do
  name = params[:train_name]
  train = Train.new({:name => name, :id => nil})
  train.save()
  redirect to('/')
end

patch('/trains/:id') do
  name = params[:train_name]
  @train = Train.find(params[:id].to_i)
  @train.update(name)
  erb(:train)
end

delete('/trains/:id') do
  @train = Train.find(params[:id].to_i)
  @train.delete
  redirect to('/trains')
end

get('/cities') do
  @cities = City.all
  erb(:cities)
end

get('/trains/:id/cities/:city_id') do
  @city = City.find(params[:city_id].to_i)
  erb(:city)
end

post('/trains/:id/cities') do
  city = City.new({:name => params[:city_name], :train_id => params[:id].to_i, :id => nil})
  city.save()
  @train = Train.find(params[:id].to_i)
  erb(:train)
end

get('/cities/:city_id') do
  erb(:city)
end

get('/cities/:city_id/edit') do
  @city = City.find(params[:city_id].to_i)
  erb(:edit_city)
end

patch('/cities/:city_id') do
  name = (params[:city_name])
  @city = City.find(params[:id].to_i)
  @city.update(name)
  erb(:cities)
end






