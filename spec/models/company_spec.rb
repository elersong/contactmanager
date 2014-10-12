require 'rails_helper'

RSpec.describe Company, :type => :model do
  
   let(:company) { Company.new(name: "the example company") }
   
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
  
  it 'responds with its phone numbers after theyre created' do
    company.save
    phone_number = company.phone_numbers.create(number: '333-4444')
    expect(phone_number.number).to eq('333-4444')
  end
  
end
