class Customer < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name, presence: true
         validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
         validates :password, presence:true, length: { minimum: 6 }


end
