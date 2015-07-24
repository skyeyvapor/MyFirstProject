#我們想建立Authentication，也就是會員，不要花長時間去去寫這機制，不健康。我們用devise gem
#1. 在Gemfile裡加入 gem 'devise'
#2. $bundle install
#3. $rails generate devise:install
#4. fix some problems：在config/environments/development.rb加入config.action_mailer.default_url_options = { host: 'localhost:3000'}這是為了有些人忘了他們的帳號密碼
#5. Setting up devise：$rails g devise:views 產生樣板，這會包括有註冊、登入、忘記密碼、Email等等頁面，放在app/views/devise目錄下。
#6. $rails g devise Member 產生 Member model 及 Migration
#7. Don't forget：$rake db:migrate
#用法：在需要登入的 controller 加上before_action :authenticate_user!
#並在 Layout 中加上登入登出選單
#8. 你可以$rake routes去看這次創造出來的new routes，可看到你可去http://localhost:3000/members/sign_up進入sign_up頁面
#元編程產生：
#prefix of helpers   					HTTP Verb	產生的Path
#new_member_session 					GET 			/members/sign_in
#destroy_member_session				DELETE		/members/sign_out
#member_password 							POST			/members/password
#new_member_password					GET  			/members/password/new
#cancel_member_registration		GET  			/members/cancel
#new_member_registration			GET  			/members/sign_up
#其中的Prefix指的是在View的Helper命名，搭配_path(相對路徑)或_url(絕對路徑)結尾就可以組合出Helper方法，例如welcome_say_hello_path方法會產生出/welcome/say_hello這樣的網址。
#但要改sign_out頁面，因原本預設為GET，所以要去app/views/layouts/_header.html.erb加入link_to "sign out", destroy_member_session_path, :method => :delete
class Member < ActiveRecord::Base #用$rails g scaffold member
	#Rails的scaffold鷹架功能會自動產生一組Model、Views跟Controller程式碼，完成一個簡易的CRUD程式
	#輸入以下指令執行Migration：$ bin/rake db:migrate，Rails這時會建立people資料表
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
