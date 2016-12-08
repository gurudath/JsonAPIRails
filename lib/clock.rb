require File.expand_path('../../config/boot', __FILE__)

require File.expand_path('../../config/environment', __FILE__)

require 'clockwork'

include Clockwork

module Clockwork

## Here Student is a domain class, having a method insertRecord to

## insert a record in DB

every(5.seconds, 'job ­ Inserting Record in DB') {  ApiKey.delete_after_five_min
}

end