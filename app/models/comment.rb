class Comment < ApplicationRecord
  belongs_to :post

  validates :text, length: { minimum: 10 }

  scope :get_ordered_comments, -> (post_id) {
    where(post: post_id).order updated_at: :desc
  }

  belongs_to :user
end
