require 'spec_helper'
require 'pry'

describe SessionsController, type: :controller do
  
  let("omniauth.auth") {
    OmniAuth::AuthHash.new({
          'provider' => 'twitter',
          'info' => {'name' => 'Alice Smith'},
          'uid' => 'abc123'
        })
  }

  describe "#create" do

    it "logs-in a NEW user from twitter data" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Alice Smith'},
        'uid' => 'abc123'
      }
      post :create
      user = User.find_by_uid_and_provider('abc123', 'twitter')
      expect(controller.current_user.id).to eq(user.id)
    end

    it "logs-in existing user from twitter data" do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Smith James'},
        'uid' => 'xyz456'
      }
      user = User.where(name: @request.env["omniauth.auth"]['info']['name'])
      post :create
      expect(user.count).to eq(1)
      expect(controller.current_user.id).to eq(user.first.id)
    end
    
    it 'redirects to the companies index page' do
      @request.env["omniauth.auth"] = {
        'provider' => 'twitter',
        'info' => {'name' => 'Charlie Allen'},
        'uid' => 'prq987'
      }
      user = User.where(name: @request.env['omniauth.auth']['info']['name'])
      post :create
      expect(response).to redirect_to(root_path)
    end

  end
  
end