require 'rails_helper'
require 'spec_helper'


RSpec.describe "People", :type => :request do
  
  let(:user) { Fabricate(:user) }
  
  describe "GET /people" do
    
    it 'redirects to "/login" with an HTTP 302 code when logged out' do
      get people_path
      expect(response).to have_http_status(302)
    end
    
  end
end
