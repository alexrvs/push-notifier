class Device < ApplicationRecord
  belongs_to :user

  validates :uuid, presence: true, uniqueness: true

  def ios?
    self.platform == 'ios'
  end

  def android?
    self.platform == 'android'
  end

end