class ShortUrl < ActiveRecord::Base

  has_many :short_visits
  belongs_to :user

  validates_presence_of :orginal_url, :shorty, :user_id, :message => 'should not be blank'
  validates_uniqueness_of :shorty,:message => 'already exists'

  def self.generate_token
    Digest::MD5.hexdigest(Time.now.to_i.to_s + rand(999999999).to_s)
  end

   def smart_add_url_protocol
    if self.orginal_url && !url_protocol_present?
      self.orginal_url = "http://#{self.orginal_url}"
    else
      self.orginal_url
    end
  end

  def url_protocol_present?
    self.orginal_url[/\Ahttp:\/\//] || self.orginal_url[/\Ahttps:\/\//]
  end

  def strip_url(url)
    url.sub!(/https\:\/\/www./, '') if url.include? "https://www."
    url.sub!(/http\:\/\/www./, '')  if url.include? "http://www."
    url.sub!(/www./, '')            if url.include? "www."
    return url
  end

  def create_vist_geo_details(request)
    begin
    require 'net/http'
    url = URI.parse("http://freegeoip.net/json/#{request.remote_ip}")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    data = JSON.parse(res.body)
    self.short_visits.create(visitor_ip: data['ip'], visitor_city: data['city'], visitor_state: data['region_name'], visitor_country: data['country_name'], visitor_country_iso: data['country_code'])
    rescue Exception => e
      p e
    end
  end

end
