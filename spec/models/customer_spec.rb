require 'rails_helper'

RSpec.describe Customer, type: :model do


  before do
    @customer = Customer.new
  end


  describe 'validations' do

    it 'is not valid if name is not present' do

      @customer.name = ''
      @customer.email = 'test@mail.com'
      @customer.password = 'passwordtest'

      @customer.save
      expect(@customer).not_to be_valid
      expect(@customer.errors.messages[:name]).to include("can't be blank")
  end


  it 'is not valid with invalid email' do

      @customer.name = 'test'
      @customer.email = 'invalid email'
      @customer.password = 'passwordtest'

      @customer.save
      expect(@customer).not_to be_valid
      expect(@customer.errors.messages[:email]).to include("is invalid")

  end

  it 'is not valid if password is not present' do

    @customer.name = 'test'
    @customer.email = 'test@mail.com'
    @customer.password = ''

    @customer.save
    expect(@customer).not_to be_valid
    expect(@customer.errors.messages[:password]).to include("can't be blank")

  end


  it 'is not valid if password is less than 6 characters' do
    @customer.name = 'test'
    @customer.email = 'test@mail.com'
    @customer.password = '123'

    @customer.save
    expect(@customer).not_to be_valid
    expect(@customer.errors.messages[:password]).to include("is too short (minimum is 6 characters)")
  end


  it 'should throw an error if the email is already registered' do

    Customer.create!(name:"customer name",email:"customer@mail.com",password:"123teste")

    customer_2 = Customer.create(name:"customer name",email:"customer@mail.com",password:"123teste")
    expect(customer_2).not_to be_valid
    expect(customer_2.errors.messages[:email]).to include("has already been taken")

  end


  end






end
