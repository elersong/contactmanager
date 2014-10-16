require 'rails_helper'
require 'pry'

RSpec.describe User, :type => :model do
  
  let(:user) { Fabricate(:user) }

  it 'has associated people contacts' do
    expect(user.people).to eq([])
  end
  
  it 'builds the associated people' do
    person1 = Fabricate(:person)
    person2 = Fabricate(:person)
    [person1, person2].each do |person|
      expect(user.people).not_to include(person)
      user.people << person
      expect(user.people).to include(person)
    end
  end
  
  it 'builds associated companies' do
      company_1 = Fabricate(:company)
      company_2 = Fabricate(:company)
      [company_1, company_2].each do |company|
        expect(user.companies).not_to include(company)
        user.companies << company
        expect(user.companies).to include(company)
      end
    end

end
