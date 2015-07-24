#$rails g controller AaaCore index events shop discussion
class AaaCoreController < ApplicationController #指網址的部分放在config/routes.rb
  def index #這些是方法
  	@title = "Home" #實例變數@title = "home"
  end

  #def events #產生Events Model前需刪除
  	#@title = "Events"
  #end

  def shop
  	@title = "Shop"
  end

  def discussion
  	@title = "Discussion"
  end
end
