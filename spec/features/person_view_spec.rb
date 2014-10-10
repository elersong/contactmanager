require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do
  
  let(:person) { Person.create(first_name: "John", last_name: "Adams") }
  
  before(:each) do
    person.phone_numbers.create(number:"555-1234")
    person.phone_numbers.create(number:"555-5678")
    visit person_path(person)
  end
  
  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end
  
  it 'has link to add new phone number' do
    expect(page).to have_link("Add Phone Number", href: new_phone_number_path(person_id: person.id))
  end
  
  it 'adds a new phone number to page' do
    page.click_link('Add Phone Number')
    page.fill_in('Number', with: "555-8888")
    page.click_button('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-8888')
  end
  
end
