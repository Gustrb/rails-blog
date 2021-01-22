class Tag < ApplicationRecord
  validates :name,
            length: { within:  3..20 },
            uniqueness: true

  has_and_belongs_to_many :posts
end
