class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, format: { with: VALID_EMAIL_REGEX }, presence: true

  after_create :create_device!

  def authentication_token
    "#{id}#{TOKEN_DELIMITER}#{access_token.last}"
  end

  def self.authenticate(token)
    id, token = token.try(:split, TOKEN_DELIMITER)
    user = User.where(id: id).first
    secure_compare_and_return(user, token) if user
  end

  def append_new_token
    access_token.push(Devise.friendly_token)
  end

  def self.secure_compare_and_return(user, token)
    index = user.access_token.find_index(token)
    if index && Devise.secure_compare(user.access_token[index], token)
      user
    else
      false
    end
  end


end
