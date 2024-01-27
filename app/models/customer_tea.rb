class CustomerTea < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
end