require "rails_helper"

RSpec.describe 'LoginController'  , :type => :request do
  describe "GET #index" do

    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
    end

    it "responds successfully with an HTTP 200 status code index" do
      get api_v1_login_index_path
      expect(response.response_code).to eq 200
      response.should be_success
    end

    it "responds successfully with an HTTP 302 status code" do
      get logout_api_v1_login_index_path
      expect(response.response_code).to eq 302
      response.should redirect_to '/'
    end

    it "responds successfully with an HTTP 200 status code verify_login" do
      post verify_login_api_v1_login_index_path , {email: 'test@test.com',password:'test123'}
      expect(response.response_code).to eq 302
    end

    it "responds successfully with an HTTP 200 status code" do
      post register_user_api_v1_login_index_path,@uparams
      expect(response.response_code).to eq 200
    end

    after(:each) do
      @new_user.destroy
    end

  end


end