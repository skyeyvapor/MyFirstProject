class ApplicationController < ActionController::Base #這裡指ApplicationController的類別繼承自某個放在ActionController的模組(或類別)裡的Base類別(::為namespace用法)
	#(如果你知道的話，其實不管是類別或模組，它們的名字基本上也就是常數而已)(大寫字母開頭命名者為常數)
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
