require "rails_helper"

RSpec.describe ApplicationController , :type => :controller do
  describe "GET #generate_token" do

    before(:each) do
      @params = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@params)
    end

    it "responds successfully with an HTTP 200 status code" do
      @new_user.save
      get "generate_token",email:'test@test.com',password:'test123'
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']['status']).to eql(true)
    end

    it "responds successfully with an HTTP 200 status code" do
      @new_user.save
      get "generate_token",email:'test@test.com',password:'test1233'
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)['data']['status']).to eql(false)
    end

    after(:each) do
      @new_user.destroy
    end

  end


end