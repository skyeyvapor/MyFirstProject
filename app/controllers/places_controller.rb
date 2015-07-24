class PlacesController < ApplicationController
  def radio #在這定義了方法，已經隱含了當routes.rb用到PlacesController的radio，就要去指到radio.html.erb
  	@time = Time.now
  	@title = "Radio"
  end
  
  #在Controller中，一個公開函式(public method)就代表一個Action，一個Action對應一個HTTP的請求和回應。
  #def video
  #	@title = "Video"
  #end
end
