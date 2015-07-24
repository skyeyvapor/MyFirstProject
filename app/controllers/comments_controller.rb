class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  #在定義method時，Ruby會自動幫我們為method產生一個symbol
  
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.where(event_id: params[:event_id]) #我們想list這Event的所有comments，Comment.all改成Comment.where
    @event = Event.find(params[:event_id]) #我們也需要detail of event
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new(event_id: params[:event_id]) #收到從show.html.erb linke_to "new comment"傳來的參數，並
    #show.html.erb裡<%= link_to 'New Comment', new_comment_path(event_id: @event) %>
    #上面這段link變成http://localhost:3000/comments/new?event_id=1
    #這裏的event_id是comment的foreign key：外來鍵是一個(或數個)指向另外一個表格主鍵的欄位。
    #Rails 在設計上，form 是綁 model 的，因此整個 form 的內容會被包成一個 hash，在這裡就是 params[:post]？
    #create action 初始一個 object ，並把 params[:post] 整包塞進這個 object 裡。
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:event_id, :details, :author)
    end
end
