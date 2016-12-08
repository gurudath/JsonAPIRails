require "rails_helper"

RSpec.describe 'ShortUrlsController'  , :type => :request do
  describe "GET #index" do

    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
      @key = ApiKey.create(user_id: @new_user.id)
      @params = { orginal_url: "yahoo.com", shorty: @key.access_token, user_id: @new_user.id, visit_count: 1 }
      @short_url = ShortUrl.new(@params)
    end

    it "responds successfully with an HTTP 200 status code index" do
      get api_v1_short_urls_path,{ :format => :json }, {'HTTP_AUTHORIZATION' =>  "Token #{@key.access_token}"}
      expect(response.response_code).to eq 200
      response.should be_success
    end

    it "responds successfully with an HTTP 200 status code new" do
      get new_api_v1_short_url_path,{ :format => :json }, {'HTTP_AUTHORIZATION' =>  "Token #{@key.access_token}"}
      expect(response.response_code).to eq 200
      response.should be_success
    end

    it "responds successfully with an HTTP 200 status code delete" do
      @short_url.save
      get api_v1_delete_short_url_path(@short_url.id),{ :format => :json }, {'HTTP_AUTHORIZATION' =>  "Token #{@key.access_token}"}
      expect(response.response_code).to eq 204
      response.should be_success
    end

    it "responds successfully with an HTTP 200 status code create" do
      post '/api/v1/short_urls',{ :format => :json , short_url:{orginal_url: "yahoo.com", shorty: @key.access_token, user_id: @new_user.id, visit_count: 1}}, {'HTTP_AUTHORIZATION' =>  "Token #{@key.access_token}"}
      expect(response.response_code).to eq 200
      response.should be_success
    end


    it "responds successfully with an HTTP 200 status code redirect" do
      @short_url.save
      get "/short/#{@key.access_token}",{ :format => :json }, {'HTTP_AUTHORIZATION' =>  "Token #{@key.access_token}"}
      expect(response.response_code).to eq 302
      response.should redirect_to @short_url.orginal_url
    end

    after(:each) do
      @short_url.destroy
      @new_user.destroy
      @key.destroy
    end

  end


end