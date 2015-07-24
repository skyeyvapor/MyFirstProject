
class EventsController < ApplicationController #繼承
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  #其實是before_action(:set_event, :only => [:show, :edit, :update, :destroy])
  #在定義method時，Ruby會自動幫我們為method產生一個symbol
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.all #index是拉列表的動作，Event.all是拉出 Event 這個 model 所有的資料。
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @comments = Comment.where(event_id: params[:id]) #改這
  end

  # GET /events/new
  def new
    @event = Event.new #新增一筆資料
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params) #<<新增時會傳入event_params方法,可以防止駭客多傳參數
    #Rails 在設計上，form 是綁 model 的，因此整個 form 的內容會被包成一個 hash，在這裡就是 params[:post]？
    #create action 初始一個 object ，並把 params[:post] 整包塞進這個 object 裡。
    respond_to do |format|
      if @event.save #當@event存入時
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private #避免被人知道參數有幾個而宣告private
    #Include a action callback回呼，需要被宣告成private
    #也可以用after_action或around_action(用在時間戳timestamp？)(use yeild in tis definition)
    before_action :authenticate_member!, :except => [:index, :show] #make sure your callback methods are declared private or protected
    #等同於before_action :authenticate_member!, :only => [:new, :edit, :create, :update, :destroy]
    

    # Use callbacks to share common setup or constraints between actions.
    def set_event #一個普通的setup action for some of the action in Event Controller
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #這裡是white list controller for event：only(early) sent parameters are permitted to be changed or sent throught the Internet
    def event_params #Rails3.0跟4.0主要的不同在這：那些被允許經由網路傳入的parameters最終到controller，need to be white-listed(設置白名單) within the controller
      #whitelist白名單，相對於黑名單，就是清單
      #這whitelisting need to be done in the controller as guardian for security
      params.require(:event).permit(:title, :date, :description) #根據permit要求僅能傳入這三個參數
    end
end
