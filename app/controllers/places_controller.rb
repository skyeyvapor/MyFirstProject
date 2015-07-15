class PlacesController < ApplicationController
  def radio
  	@time = Time.now
  	@title = "Radio"
  end

  def video
  	@title = "Video"
  end
end
