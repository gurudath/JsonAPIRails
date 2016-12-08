require "rails_helper"

RSpec.describe 'ShortVisitController'  , :type => :request do
  describe "GET #index" do


    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
      @key = ApiKey.create(user_id: @new_user.id)
      @params = { orginal_url: "yahoo.com", shorty: @key.access_token, user_id: @new_user.id, visit_count: 1 }
      @short_url = ShortUrl.new(@params)
    end

    it "responds successfully with an HTTP 200 status code" do
      get api_v1_short_visits_path,{ :format => :json }, {'HTTP_AUTHORIZATION' =>  "Token #{@key.access_token}"}
      expect(response.response_code).to eq 200
      response.should be_success
    end

    after(:each) do
      @short_url.destroy
      @new_user.destroy
      @key.destroy
    end

  end


end