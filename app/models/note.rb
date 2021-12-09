class Note < ApplicationRecord
  DEFAULT_EXPIRE_TIME = 1.month

  before_create :set_expired_at

  belongs_to :author, class_name: 'Account'
  has_many :note_taggings
  has_many :tags, through: :note_taggings

  private

  def set_expired_at
    self.expired_at ||= Time.current + DEFAULT_EXPIRE_TIME
  end
end
