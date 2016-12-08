require "rails_helper"
require 'rspec/autorun'

RSpec.describe ShortUrl , type: :model do

  context "tests for associations" do
    it { should have_many(:short_visits)}
    it { should belong_to(:user)}
  end

  context "tests for validations" do
    it { should validate_presence_of(:orginal_url).with_message(/should not be blank/)}
    it { should validate_presence_of(:shorty).with_message(/should not be blank/)}
    it { should validate_presence_of(:user_id).with_message(/should not be blank/)}
    it { should validate_uniqueness_of(:shorty).with_message(/already exists/)}
  end

  context "tests for methods in model 1" do

    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
      @responce = JSON.parse(`curl "http://localhost:4000/generate_token?email=test@test.com&password=test123"`)
      @params = { orginal_url: "https://yahoo.com", shorty: @responce["data"]["token"], user_id: @new_user.id, visit_count: 1 }
      @short_url = ShortUrl.new(@params)
    end

    it "should save the short_url on passing valid parameters" do
      @short_url_count_initial = ShortUrl.count
      @short_url.save
      @short_url_count_final = ShortUrl.count
      expect(@short_url_count_final - @short_url_count_initial).to eql(1)
    end

    it "generate token" do
      data = ShortUrl.generate_token
      expect(data.empty?).to eql(false)
    end

     it "strip_url http://www.google.com " do
      data = @short_url.strip_url("http://www.google.com")
      expect(data).to eql("google.com")
     end

     it "strip_url https://www.google.com " do
      data = @short_url.strip_url("https://www.google.com")
      expect(data).to eql("google.com")
     end

    after(:each) do
      @short_url.destroy
      @new_user.destroy
    end

  end

  context "tests for methods in model 2" do

    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
      @responce = JSON.parse(`curl "http://localhost:4000/generate_token?email=test@test.com&password=test123"`)
      @params = { orginal_url: "yahoo.com", shorty: @responce["data"]["token"], user_id: @new_user.id, visit_count: 1 }
      @short_url = ShortUrl.new(@params)
    end

    it "strip_url yahoo.com " do
      @short_url.save
      data = @short_url.smart_add_url_protocol
      expect(data).to eql("http://yahoo.com")
    end

    after(:each) do
      @short_url.destroy
      @new_user.destroy
    end

  end


  context "tests for methods in model 3" do

    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
      @responce = JSON.parse(`curl "http://localhost:4000/generate_token?email=test@test.com&password=test123"`)
      @params = { orginal_url: "yahoo.com", shorty: @responce["data"]["token"], user_id: @new_user.id, visit_count: 1 }
      @short_url = ShortUrl.new(@params)
    end

    it "strip_url yahoo.com " do
      @short_url.save
      data = @short_url.smart_add_url_protocol
      expect(data).to eql("http://yahoo.com")
    end

    after(:each) do
      @short_url.destroy
      @new_user.destroy
    end

  end


  context "tests for methods in model 4" do

    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
      @responce = JSON.parse(`curl "http://localhost:4000/generate_token?email=test@test.com&password=test123"`)
      @params = { orginal_url: "http://yahoo.com", shorty: @responce["data"]["token"], user_id: @new_user.id, visit_count: 1 }
      @short_url = ShortUrl.new(@params)
    end

    it "strip_url http://yahoo.com " do
      @short_url.save
      data = @short_url.smart_add_url_protocol
      expect(data).to eql("http://yahoo.com")
    end

    after(:each) do
      @short_url.destroy
      @new_user.destroy
    end

  end

  context "tests for methods in model 4" do

    before(:each) do
      @uparams = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
      @new_user = User.new(@uparams)
      @new_user.save
      @responce = JSON.parse(`curl "http://localhost:4000/generate_token?email=test@test.com&password=test123"`)
      @params = { orginal_url: "https://yahoo.com", shorty: @responce["data"]["token"], user_id: @new_user.id, visit_count: 1 }
      @short_url = ShortUrl.new(@params)
    end

    it "strip_url https://yahoo.com " do
      @short_url.save
      data = @short_url.smart_add_url_protocol
      expect(data).to eql("https://yahoo.com")
    end

    after(:each) do
      @short_url.destroy
      @new_user.destroy
    end

  end


end
