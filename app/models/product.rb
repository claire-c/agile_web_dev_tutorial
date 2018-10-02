class Product < ApplicationRecord

  # Validates that the image, desription and image url must be completed.
  validates :title, :description, :image_url, presence: true

  # Validates that the price needs to be greater than 0.01 and needs to be a number.
  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  # Validates that the title needs to be unique.
  validates :title, uniqueness: true

  # Validates that the image must be a jpg, png or gif via a regex. The allow_blank option avoids getting multiple error messages when the field is blank.
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'Must be a URL for gif, jpg or png image.'
  }

end
