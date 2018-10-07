class Cart < ApplicationRecord
  #The dependent key means that if we destroy a cart object, it will also destroy any corresponding line items.
  has_many :line_items, dependent: :destroy
end
