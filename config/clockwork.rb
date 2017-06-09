
require 'clockwork'

every 1.hour do

  Subber.all.each do |server|
    # call gregs api and set its appropriate data to statistics
  end

end
