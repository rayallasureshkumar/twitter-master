class Tweet < ActiveRecord::Base
  attr_accessible :comment, :user_id, :retweet_id
  belongs_to :user
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
  validates_length_of :comment, :within => 1..160,
    :too_long => "- Your tweet can only be {{count}} characters long",
    :too_short => "- Your tweet must be at least {{count}} character long"

  def retweet_by(retweeter)
    if self.user == retweeter
      "Sorry, you can't retweet you own tweet"
    elsif self.retweets.where(user_id: retweeter.id).present?
      "You already retweeted!"
    else
      s = tweet.new
      s.comment = "RS #{tweet.user.name}: #{tweet.status}"
      s.original_tweet = tweet
      s.user = current_user
      s.save
      "Succesfully retweeted"
    end
  end
end
