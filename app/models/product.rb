class Product < ApplicationRecord

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  # Validates that the image, desription and image url must be completed.
  validates :title, :description, :image_url, presence: true

  # Validates that the price needs to be greater than 0.01 and needs to be a number.
  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  # Validates that the title needs to be unique and length is ten characters long.
  validates :title, uniqueness: true, length: { minimum: 10, message: 'Must be ten characters long' }

  # Validates that the image must be a jpg, png or gif via a regex. The allow_blank option avoids getting multiple error messages when the field is blank.
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'Must be a URL for gif, jpg or png image.'
  }

  private
    # This is a hook method. It is called before Rails attempts to destroy a row in the db. If the hook method throws abort then the row isn't destroyed and error message runs. The error is associated with the base object in this case, not an individual attribute of the object.
    def ensure_not_referenced_by_any_line_item
      unless line_items.empty?
        errors.add(:base, 'Line items present')
        throw :abort
      end
    end
end
