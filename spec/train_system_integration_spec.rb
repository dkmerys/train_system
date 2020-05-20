require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)




describe('create a train path', {:type => :feature}) do
  it('creates an train and then goes to the trains page') do
    visit('/trains')
    click_on('Add a new train')
    fill_in('train_name', :with => 'purple line')
    click_on('Submit')
    expect(page).to have_content('purple line')
  end
end

describe('create a city path', {:type => :feature}) do
  it('creates a city and then goes to the city page') do
    train = Train.new({:name => "Thomas", :id => nil})
    train.save
    visit("/trains/#{train.id}")
    fill_in("city_name", :with => 'Portland')
    click_on("Add City")
    expect(page).to have_content("Portland")
  end
end

describe('update and delete a city path', {:type => :feature}) do
  it('changes a citys name, then deletes it') do
    train = Train.new({:name => "Thomas", :id => nil})
    train.save
    city = City.new({:name => "Oregon City", :train_id => train.id, :id => nil})
    city.save
    visit("/trains")
    click_on("See all Cities")
    click_on("Oregon City")
    click_link("Edit City")
    fill_in("city_name", :with => "Carson City")
    click_on("Update")
    click_on("Carson City")
    click_link("Edit City")
    click_on("Delete city")
    expect(page).to have_no_content("Carson City")
  end
end

describe('update and delete a train path', {:type => :feature}) do
  it('changes a trains name, then deletes it') do
    train = Train.new({:name => "Thomas", :id => nil})
    train.save
    city = City.new({:name => "Oregon City", :train_id => train.id, :id => nil})
    city.save
    visit("/trains")
    click_on("See all Cities")
    click_on("Oregon City")
    click_link("Edit City")
    fill_in("city_name", :with => "Carson City")
    click_on("Update")
    click_on("Carson City")
    click_link("Edit City")
    click_on("Delete city")
    expect(page).to have_no_content("Carson City")
  end
end