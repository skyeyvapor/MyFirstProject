# route 可以和 controller 完全切離，是上下游的關係，route 負責 mapping 網址的組成，把東西包裝好才轉給 controller，所以可以沒必要把 controller 的思維帶到 route 來
Rails.application.routes.draw do #加入這一行，就是具體在 rails 實作 RESTful 支援的方式。
  #routes.rb會先去render layouts/application.html.erb這網頁，裡的yeild會被root所指的網頁取代
  #注意到在routes.rb中，越上面越優先。是如果有網址同時符合多個規則，會使用最上面的規則。
  devise_for :members

  #REST：表象化狀態轉變Representational State Transfer
  #RESTful路由設計使用了REST的概念來建立一整組的命名路由(named routes)。
  #RESTful路由：如此就會自動建立四個命名路由(named routes)，搭配四個HTTP動詞，對應到七個Actions。輸入bin/rake routes也會列出目前設定的路由規則有哪些
  resources :events #generate whole set of routes for events
  resources :comments #Rails增加新成員,用"resources:XXXs"方法自動獲得7個路徑，根據Rails慣例resources的名稱必須複數
  #$rails console 可進入Rails命令機($rails console)狀態，$"fish".pluralize 詢問Rails對此單字複數是什麼？ =>"fish"，control+d離開
  
  #命名路由Named Routes：幫助我們產生URL helper如meetings_url或meetings_path，而不需要用{:controller => 'meetings', :action => 'index'}的方式：
  #就像是：get '/meetings' => 'events#index', :as => "meetings"其中:as的部份就會產生一個meetings_path和meetings_url的Helpers，_path和_url的差別在於前者是相對路徑，後者是絕對路徑。

  #外卡路由：match ':controller(/:action(/:id(.:format)))', :via => :all
  #透過 :via 參數指定 HTTP Verb 動詞
  match '/index' => "aaa_core#index", via: :get #若得到使用者瀏覽器傳來'/index'，使用controller aaa_core的index方法
  #簡寫，等同於：get '/index', to: 'aaa_core#index' (get '路徑',to: '控制名#方法名')
  #match '/events'=> "aaa_core#events", via: :get
  match '/shop'=> "aaa_core#shop", via: :get
  match '/discussion'=> "aaa_core#discussion", via: :get

  #一般路徑Regular Routes：
  get 'places/radio'#, to: 'places#video' #沒說要把http://localhost:3000/places/radio對應到哪，但Rails知道要maps這段網址到places Controller的radio Action
  #當此處放to: 'places#video'表把http://localhost:3000/places/radio對應到places Controller的video Action(video Action也預設要去訪問video.html.erb)(此時因為下一行當然/places/video也會對應到video.html.erb)，
  #但會報錯說video.html.erb裡的link(:action => "radio")沒有route matches(因radio Action理應對應到radio.html.erb，此時當然可以去訪問radio.hrml.erb，但網址該怎麼回傳？/places/radio？無限迴圈，/places/video？不對啊，所以出錯match不到)
  get "places/video" #就知道要去訪問videio.html.erb #改成places/就不知道要去找哪個了
  
  #match "/index" => "places#radio", via: :get
  #match "/video" => "places#video", via: :get

  #設定首頁
  root 'aaa_core#index' #root('controller name#def name')
  #等於root :to => "aaa_core#index"

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
