class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  # GET /friends or /friends.json
  def index
    @friends =  Friend.all
    @categories = Category.all
    cate = params[:cate]
    if !cate.nil?
      @friends = Friend.where(:category_id => cate)
    else
      @friends = Friend.all
    end

    respond_to do |format|
      format.html
      format.csv { send_data current_user.friends.to_csv }
    end
  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    #@friend = Friend.new
    @friend = current_user.friends.build
    #@categories = Category.all.map {|c| [c.category,c.id]} 


  end

  def search  
        @query = params[:search]
        @friends = current_user.friends.where("lower(first_name) LIKE ?", "%#{@query}%") 
  end
    
  

  # GET /friends/1/edit
  def edit
    #@categories = Category.all.map {|c| [c.category,c.id]} 

  end

  # POST /friends or /friends.json
  def create
    #@friend = Friend.new(friend_params)
    @friend = current_user.friends.build(friend_params)
    #@friend.category_id = params[:category_id] 

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: "Friend was successfully created." }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
         #@friend.category_id = params[:category_id]
        format.html { redirect_to @friend, notice: "Friend was successfully updated." }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: "Friend was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def import
    Friend.import(params[:file])
    redirect_to friends_path, notice:"Friends  Added Successfully"
  end
  def correct_user
    @friend = current_user.friends.find_by(id: params[:id])
    redirect_to friends_path, notice: "Not Authorized To Edit this Friend" if @friend.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id, :dob,  :category_id, :gender)
      

    end
    
end
