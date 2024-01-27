class Customer < ApplicationRecord
  has_one :subscription
  has_many :customer_teas
  has_many :teas, through: :customer_teas

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :address, presence: true
end