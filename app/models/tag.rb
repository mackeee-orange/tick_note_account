class Tag < ApplicationRecord
  has_many :note_taggings
  has_many :notes, through: :note_taggings
end
