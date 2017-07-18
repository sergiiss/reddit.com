class Post < ApplicationRecord
  belongs_to :user

  has_many :votes
  has_many :comments

  validates :title, :text, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def summ_votes_to_post
    summ = votes.where(vote_type: 'up').count - votes.where(vote_type: 'down').count

    if summ < 0
      summ = 0
    else
      summ
    end
  end

  def vote_up(user)
    down = votes.find_by(user_id: user.id, vote_type: 'down')
    down.destroy if down.present?

    votes.create({ user_id: user.id }.merge(vote_type: 'up'))
  end

  def vote_down(user)
    up = votes.find_by(user_id: user.id, vote_type: 'up')
    up.destroy if up.present?

    votes.create({ user_id: user.id }.merge(vote_type: 'down'))
  end

  def from_vote_up?(user)
    votes.where({user_id: user.id, vote_type: 'up'}).present?
  end

  def from_vote_down?(user)
    votes.where({user_id: user.id, vote_type: 'down'}).present?
  end
end
