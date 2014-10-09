require 'rails_helper'

# this block will wrap all of the tests for Person model
RSpec.describe Person, :type => :model do
  
  it 'is valid' do
    expect(Person.new(first_name: "Alice", last_name:"Smith")).to be_valid
  end
  
  it 'is invalid without a first name' do
    person = Person.new(first_name: nil, last_name: "Smith")
    expect(person).not_to be_valid
  end
  
  it 'is invalid without a last name' do
    person = Person.new(first_name: "Alice", last_name: nil)
    expect(person).not_to be_valid
  end
  
end
