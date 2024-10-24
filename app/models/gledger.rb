class Gledger < ApplicationRecord
validates :accountno, :description, :sourceno, :amount, presence: true
 belongs_to :payment, optional: true
  belongs_to :paymentline, optional: true


end
