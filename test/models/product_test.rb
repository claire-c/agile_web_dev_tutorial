require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test 'product attributes must not be empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test 'product price must be positive' do
    product = Product.new( title: 'My book title', description: 'Blah', image_url: 'zzz.jpg' )

    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new( title: 'My book title', description: 'Blah', image_url: image_url, price: 1 )
  end

  test 'image_url' do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c.d/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

    # The string parameter is optional and will print out in case the test fails along with error message.
    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end
  end

  test 'product is not valid without a unique title' do
    product = Product.new(
       title: products(:ruby).title,
       description: 'blah',
       price: 1,
       image_url: 'fred.gif'
      )

    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:title]
  end

  test 'product title character validation' do
    product = Product.new(
       title: 'yo',
       description: 'blah',
       price: 1,
       image_url: 'fred.gif'
      )

    assert product.invalid?
    assert_equal ['Must be ten characters long'], product.errors[:title]

    product2 = Product.new(
       title: '1234567890',
       description: 'blah',
       price: 1,
       image_url: 'fred.gif'
      )
    assert product2.valid?
  end
end
