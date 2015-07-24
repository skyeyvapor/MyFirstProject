#在aaa_core_controller中刪除def events
#刪除events view
#刪除/events route in routes.rb(之後會新增RESTful路由：resources: events)
#Build a CRUD interface for the Event model：$rails g scaffold Event title:string date:date description:text
#Scaffold also will generate Migration file(db/migrate/xx.rb) which capture the basic migration types which is used to generate database, you can use migration files to update and remove tables
#$rake db:migrate
class Event < ActiveRecord::Base
	#Event Model Class創造後沒有內容，但id, title, date, description等attributes到哪去了呢？
	#因Active Record使用Metaprogramming(元編程)自動加features到model classes：
	#也就是，它加了attributes to the model classes基於相關的database table的column
	#也就是，attributes of model就是database itself
	#你不需自己寫model的特性，只要繼承ActiveRecord::Base
	#(Metaprogramming是ruby的一个特性，可以动态的修改语言结构，比如类结构，模块结构和实例变量信息等等。甚至可以在运行时往程序中加入并运行新的代码而不需要重启你的程序。)
	#Ruby的類別層級內也可以執行程式? puts in Class
validates_presence_of :title, :date, :description
	#validates_uniqueness_of :title
	has_many :comments, :dependent => :destroy #當Event destroyed時要destroy all dependent comments
	#為何"destroy" not "delete"？ delete很快，而destroy會先load an instance of the active record object(其實destroy is an instance method)
	#因there is no database activity that destroy the dependence, this is done in the active record object 
	#等同於has_many(:comments, :dependent => :destroy)
end
