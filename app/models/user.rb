class User < ActiveRecord::Base
  has_many :short_urls
  has_many :short_visits , through: :short_urls
  has_one :api_key

  validates_presence_of :password, :name ,:email, presence: true, :message => 'should not be blank'
  validates_uniqueness_of :email,:message => 'already exists'

  def self.authenticate(email, password)
    if (email.present? and password.present?)
      user=User.where(:password => Digest::MD5.hexdigest(password), :email => email).first
      if (user.present?)
        return {data: {status: true, user: user, message: "Successful Login"}}
      else
        return {data: {status: false, user: nil, message: "Unsuccessful Login"}}
      end
    else
      return {data: {status: false, user: nil, message: "No valid details"}}
    end
  end

  def display_name
    self.name || self.email
  end
end
