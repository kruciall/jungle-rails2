require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save correctly if all inputs are filled' do
      @category = Category.create(name: "Trees")
      @product = Product.new(name: 'Fiyah', price: 25, quantity: 5, category: @category);
      expect(@product.save).to be true
  end
  
    it 'should not save without a product name' do
      @category = Category.create(name: "Trees")
      @product = Product.create(price: 25, quantity: 120, category: @category);
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save without a product price' do
      @category = Category.create(name: "Trees")
      @product = Product.create(name: 'Fiyah', quantity: 5, category: @category);
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save without a product quantity' do
      @category = Category.create(name: "Trees")
      @product = Product.create(name: 'Fiyah', price: 1000, category: @category);
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without a category name' do
      @product = Product.create(name: 'Fiyah', quantity: 50, price: 1000);
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
