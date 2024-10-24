class Bank < ApplicationRecord
 
 belongs_to :payment
  has_many :receipts

end
