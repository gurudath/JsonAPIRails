require "rails_helper"
require 'rspec/autorun'

RSpec.describe User , type: :model do

  context "tests for associations" do
    it { should have_many(:short_urls)}
    it { should have_many(:short_visits)}
    it { should have_one(:api_key)}
  end
  
  context "tests for validations" do
    it { should validate_presence_of(:email).with_message(/should not be blank/)}
    it { should validate_presence_of(:name).with_message(/should not be blank/)}
    it { should validate_presence_of(:password).with_message(/should not be blank/)}
    it { should validate_uniqueness_of(:email).with_message(/already exists/)}
  end

  context "tests for methods in model" do

    before(:each) do
        @params = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com',name: 'testuser' }
        @new_user = User.new(@params)
    end

    it "should save the user on passing valid parameters" do
      @user_count_initial = User.count
      @new_user.save
      @user_count_final = User.count
      expect(@user_count_final - @user_count_initial).to eql(1)
    end

    it "should be valid the user on authenticate" do
      @new_user.save
      response = User.authenticate('test@test.com','test123')
      expect(response[:data][:status]).to eql(true)
    end

    it "should not be valid the user on authenticate" do
      @new_user.save
      response = User.authenticate('test@test.com','test1234')
      expect(response[:data][:status]).to eql(false)
    end

    it "should be valid the user on display name" do
      @new_user.save
      response = @new_user.display_name
      expect(response).to eql(@new_user.name)
    end

    after(:each) do
      @new_user.destroy
    end

  end

  context "tests for methods in model not valid" do

    before(:each) do
      @params = {password: Digest::MD5.hexdigest('test123'),email: 'test@test.com' }
      @new_user = User.new(@params)
    end

    it "should not save the user on passing invalid parameters" do
      @user_count_initial = User.count
      @new_user.save
      @user_count_final = User.count
      expect(@user_count_final - @user_count_initial).to eql(0)
    end

    it "should be valid the user on display email" do
      @new_user.save
      response = @new_user.display_name
      expect(response).to eql(@new_user.email)
    end

    after(:each) do
      @new_user.destroy
    end

  end



end
