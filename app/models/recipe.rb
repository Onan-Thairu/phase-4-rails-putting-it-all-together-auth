class Recipe < ApplicationRecord
  validates :title, :instructions, presence: true
  validates :instructions, length: { minimum: 50 }

  belongs_to :user
end
