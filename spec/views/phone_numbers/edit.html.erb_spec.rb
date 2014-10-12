require 'rails_helper'

RSpec.describe "phone_numbers/edit", :type => :view do
  before(:each) do
    @phone_number = assign(:phone_number, PhoneNumber.create!(
      :number => "MyString",
      :contact_id => 1,
      :contact_type => "Person"
    ))
  end

  it "renders the edit phone_number form" do
    render

    assert_select "form[action=?][method=?]", phone_number_path(@phone_number), "post" do

      assert_select "input#phone_number_number[name=?]", "phone_number[number]"

      assert_select "input#phone_number_contact_id[name=?]", "phone_number[contact_id]"
      
      assert_select "input#phone_number_contact_type[name=?]", "phone_number[contact_type]"
    end
  end
end
