class Tea < ApplicationRecord
  has_many :customer_teas
  has_many :customers, through: :customer_teas
  has_many :subscriptions, through: :customers

  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true
  validates :brew_time, presence: true
end
