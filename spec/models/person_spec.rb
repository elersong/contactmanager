require 'rails_helper'

# this block will wrap all of the tests for Person model
RSpec.describe Person, :type => :model do
  
  # spec/fabricators/person_fabricator.rb
  let(:person) { Fabricate(:person) }
  
  it 'is valid' do
    expect(person).to be_valid
  end
  
  it 'is invalid without a first name' do
    person.first_name = nil
    expect(person).not_to be_valid
  end
  
  it 'is invalid without a last name' do
    person.last_name = nil
    expect(person).not_to be_valid
  end
  
  it 'responds with its created phone numbers' do
    person.phone_numbers.build(number: '555-8888')
    expect(person.phone_numbers.map(&:number)).to eq(['555-8888'])
  end
  
  it 'responds with its created email addresses' do
    person.email_addresses.build(address: 'me@example.com')
    expect(person.email_addresses.map(&:address)).to eq(['me@example.com'])
  end
  
  it 'belongs to an associated user' do
    expect(person.user.class).to eq(User)
  end
  
end
