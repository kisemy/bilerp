class Receipt < ApplicationRecord
has_many :receipt_lines, dependent: :destroy
belongs_to :bank, optional: true
#accepts_nested_attributes_for :invoice_lines

 accepts_nested_attributes_for :receipt_lines, allow_destroy: true 
  
  has_many :receipt_lines, dependent: :destroy
  accepts_nested_attributes_for :receipt_lines, allow_destroy: true 
  
  
  
  
  
  
end
