class User < ApplicationRecord
  belongs_to :city
  has_many :comments
  has_many :likes
  has_many :gossips
  has_many :comment_of_comments
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
end
