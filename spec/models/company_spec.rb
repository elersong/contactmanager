require 'rails_helper'

RSpec.describe Company, :type => :model do
  
   let(:company) { Fabricate(:company) }
   
  it 'is valid' do
    expect(company).to be_valid
  end
  
  it 'is invalid without a name' do
    company.name = nil
    expect(company).to_not be_valid
  end
  
  it 'has an array of phone numbers' do
    expect(company.phone_numbers).to eq([])
  end
  
  it 'has an array of email addresses' do
    expect(company.email_addresses).to eq([])
  end
  
  it 'responds with its created phone numbers' do
    company.phone_numbers.build(number: '555-8888')
    expect(company.phone_numbers.map(&:number)).to eq(['555-8888'])
  end

  it 'responds with its created email addresses' do
    company.email_addresses.build(address: 'me@example.com')
    expect(company.email_addresses.map(&:address)).to eq(['me@example.com'])
  end
  
end
