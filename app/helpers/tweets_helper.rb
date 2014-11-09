module TweetsHelper
  def callback(tweet)
    tweet.gsub(/@([a-zA-Z\.\-_]{3,20})/) do |m|
      user = User.find_by_login $1
      return m unless user
      link_to m, user_tweets_path($1)
    end
  end

  def arify(tweet)
    tweet.gsub(/(<a.*?>.*?<.*?>)|(\w{3})/) {|m| m.concat '&#8203;'}
  end

  def create_follow_link(user, current_user)
    unless user == current_user
      leaders = current_user.leaders
      if leaders.include?(user)
        link_to 'unfollow', user_leader_path(current_user, user), :method => :delete
      else
        link_to 'follow', user_leaders_path(user), :method => :post
      end
    end if current_user
  end
end