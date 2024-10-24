class Paymentline < ApplicationRecord
  belongs_to :payment
 
  belongs_to :customer, optional: true
  belongs_to :vendor, optional: true
  belongs_to :bank, optional: true
  belongs_to :acchart, optional: true

 has_many :account_types
 
 
  
  
  
end
