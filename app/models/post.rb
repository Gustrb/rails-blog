class Post < ApplicationRecord
  validates :title,
            length: { within: 1..100 },
            uniqueness: true

  validates :description,
            length: { minimum: 10 }

  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :tags, before_add: :check_uniqueness_of_tag

  private
    def check_uniqueness_of_tag(tag)
      raise ActiveRecord::RecordNotUnique, "#{tag.id} has already been taken" if self.tags.include? tag
    end
end
