class Note < ApplicationRecord
  DEFAULT_EXPIRE_TIME = 1.month

  belongs_to :author, class_name: 'Account'
  has_many :note_taggings
  has_many :tags, through: :note_taggings
end
