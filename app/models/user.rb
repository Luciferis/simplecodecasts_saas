class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  attr_accessor :stripe_card_token
  def save_with_payment
    if valid?
      puts "Creating customer"
      customer = Stripe::Customer.create(email: email, plan: plan_id, card: stripe_card_token)
      puts "Customer ID:"
      puts customer.id
      self.stripe_customer_token = customer.id
      puts "stripe_customer_token: "
      puts self.stripe_customer_token
      save!
    end
  end
end
