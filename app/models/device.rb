class Device < ApplicationRecord
  belongs_to :user

  validates :uuid, presence: true, uniqueness: true
end