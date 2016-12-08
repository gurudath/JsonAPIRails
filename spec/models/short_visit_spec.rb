require "rails_helper"
require 'rspec/autorun'

RSpec.describe ShortVisit , type: :model do

  context "tests for associations" do
    it { should belong_to(:short_url)}
  end

end
