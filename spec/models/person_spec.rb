require 'rails_helper'

# this block will wrap all of the tests for Person model
RSpec.describe Person, :type => :model do
  
  let(:person) do
    Person.new(first_name: "Alice", last_name: "Cooper")
  end
  
  it 'is valid' do
    expect(Person.new(first_name: "Alice", last_name:"Smith")).to be_valid
  end
  
  it 'is invalid without a first name' do
    person.first_name = nil
    expect(person).not_to be_valid
  end
  
  it 'is invalid without a last name' do
    person.last_name = nil
    expect(person).not_to be_valid
  end
  
end
