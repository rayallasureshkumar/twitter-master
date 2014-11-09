class TweetsController < ApplicationController
  before_filter :require_user, :only => [:new, :create]
  before_filter :allow_create
  
  def index
    if params[:user_id]
      @tweets = Tweet.find :all, :conditions => {:user_id => params[:user_id]}, :order => "created_at desc"
      @tweet = Tweet.new
      @user = User.find :first, :conditions => {:id => params[:user_id]}
      @current_is_user_page = @user && current_user && @user.login == current_user.login
    else
      @tweets = Tweet.all :order => "created_at desc"
    end

    respond_to do |format|
      format.html 
    end
  end

  def show
    @tweet = Tweet.find(params[:id])

    respond_to do |format|
      format.html 
    end
  end

  def new
    @tweet = Tweet.new

    respond_to do |format|
      format.html 
    end
  end

  def create
    @tweet = Tweet.new(params[:tweet])
    @tweet.user_id = current_user.id

    respond_to do |format|
      if @tweet.save
        flash[:notice] = 'Tweet was successfully created.'
        format.html { redirect_to user_tweets_path(current_user) }
        format.xml  { render :xml => @tweet, :status => :created, :location => @tweet }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tweet.errors, :status => :unprocessable_entity }
      end
    end
  end

  def retweet
    @retweet = Tweet.new(retweet_params)
    @retweet.save
  end

  private
  def allow_create
    @allow_create = params[:user_id] && current_user && params[:user_id].to_i == current_user.id
  end

  def retweet_params
    params.require(:retweet).permit(:retweet_id, :comment).merge(user_id: current_user.id)
  end
end
