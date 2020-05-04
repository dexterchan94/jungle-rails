require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do

    it "is valid with valid attributes" do
      @category = Category.create(name: "Vegetables")
      @product = @category.products.create(name:"Potato", quantity: 99, price: 99)
      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      @category = Category.create(name: "Vegetables")
      @product = @category.products.create(quantity: 99, price: 99)
      expect(@product).to_not be_valid
    end

    it "is not valid without a price" do
      @category = Category.create(name: "Vegetables")
      @product = @category.products.create(name:"Potato", quantity: 99)
      expect(@product).to_not be_valid
    end

    it "is not valid without a quantity" do
      @category = Category.create(name: "Vegetables")
      @product = @category.products.create(name:"Potato", price: 99)
      expect(@product).to_not be_valid
    end

    it "is not valid without a category" do
      @product = Product.create(name:"Potato", quantity: 99, price: 99)
      expect(@product).to_not be_valid
    end

  end

end
