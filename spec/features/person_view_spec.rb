require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the person view', type: :feature do
  describe "(phone number)" do 
    
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
      expect(page).to have_link("Add Phone Number", href: new_phone_number_path(contact_id: person.id, contact_type: "Person"))
    end
    
    it 'adds a new phone number to page' do
      page.click_link('Add Phone Number')
      page.fill_in('Number', with: "555-8888")
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end
    
    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end
    
    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number
      
      first(:link, 'edit').click
      page.fill_in('Number', with: "555-9191")
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end
    
    it 'has links to delete phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
  end
  
  describe '(email address)' do
    
    let(:person) { Person.create(first_name: "John", last_name: "Adams") }
    
    before(:each) do
      person.email_addresses.create(address: "sample@sample.org", person_id: person.id)
      person.email_addresses.create(address:"this@that.net", person_id: person.id)
      visit person_path(person)
    end
    
    it 'organizes email_addresses into <li> elements on the person"s show page' do
      email = person.email_addresses.last
      expect(page).to have_selector('li', text: email.address)
    end
    
    it 'has an "add email address" link' do
      expect(page).to have_link("Add Email Address", href: new_email_address_path(person_id: person.id))
    end
    
    it 'adds a new email address to page' do
      page.click_link('Add Email Address')
      page.fill_in('Address', with: "address@formtest.spec")
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('address@formtest.spec')
    end
    
    it 'has links to edit email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end
    
    it 'edits an email address and redirects to person page' do
      email = person.email_addresses.first
      old_email = email.address
      first(:link, 'edit').click
      page.fill_in('Address', with: "new@email.org")
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('new@email.org')
      expect(page).to_not have_content(old_email)
    end
    
    it 'has links to delete email addresses' do
      person.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end
    
  end
end
