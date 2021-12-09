class Vote < ApplicationRecord
  validates :value, presence: true
end
