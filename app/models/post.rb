class Post < ApplicationRecord
  belongs_to :user

  has_many :vote_table

  validates :title, :text, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def from_vote_up?(user)
    vote_table.where({user_id: user.id, vote_type: 'up'}).present?
  end

  def from_vote_down?(user)
    vote_table.where({user_id: user.id, vote_type: 'down'}).present?
  end
end
