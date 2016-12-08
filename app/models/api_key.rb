class ApiKey < ActiveRecord::Base
  before_create :generate_access_token
  belongs_to :user

  def self.delete_after_five_min
    puts "delete_after_five_min"
    ApiKey.where("created_at <= ?", Time.now - 5.minutes).destroy_all
  end

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end


end
