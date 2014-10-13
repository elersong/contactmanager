require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the company view', type: :feature do 
 describe '(phone number)' do
    
    let(:company) { Company.create(name: "The Testing View Corporation") }
    
    before(:each) do
      company.phone_numbers.create(number:"555-1234")
      company.phone_numbers.create(number:"555-5678")
      visit company_path(company)
    end
    
    it 'displays that company phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end
    
    it 'has link to add new phone number' do
      expect(page).to have_link("Add Phone Number", href: new_phone_number_path(contact_id: company.id, contact_type: "Company"))
    end
    
    it 'adds a new phone number to page' do
      page.click_link('Add Phone Number')
      page.fill_in('Number', with: "555-8888")
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end
    
    it 'has links to edit phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end
    
    it 'edits a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number
      
      first(:link, 'edit').click
      page.fill_in('Number', with: "555-9191")
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end
    
    it 'has links to delete phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end
 end
 
 context '(email address)' do
    
    let(:company) { Company.create(name: "The Testing View Corporation") }
    
    before(:each) do
      company.email_addresses.create(address: "company_view_spec@test.com")
      company.email_addresses.create(address: "again_company_view_spec2@test.com")
      visit company_path(company)
    end
    
    it 'displays that companys email addresses' do
      company.email_addresses.each do |email|
        expect(page).to have_content(email.address)
      end
    end
    
    it 'has link to add new email address' do
      expect(page).to have_link("Add Email Address", href: new_email_address_path(contact_id: company.id, contact_type: "Company"))
    end
    
    it 'adds a new email address to page' do
      page.click_link('Add Email Address')
      page.fill_in('Address', with: "company_view_spec@test3.com")
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('company_view_spec@test3.com')
    end
    
    it 'has links to edit email addresses' do
      company.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end
    
    it 'edits an email address' do
      email = company.email_addresses.first
      old_email = email.address
      
      first(:link, 'edit').click
      page.fill_in('Address', with: "edited email address string")
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content("edited email address string")
      expect(page).to_not have_content(old_email)
    end
    
    it 'has links to delete email addresses' do
      company.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end
 end
 
end