class TweetsController < ApplicationController

  def index 
    @tweets = Tweet.all
    render 'tweets/index'
  end 

  def create 
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create'
      else 
        render json: { success: false }
      end 
    else 
      render json: { success: false }
    end 
  end

  # need to make the jbuilder create template. That is where I left off.


  private 

    def tweet_params
      params.require(:tweet).permit(:message)
    end 
end
