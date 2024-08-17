class Customer < ApplicationRecord
  has_many :nfces, dependent: :destroy
  has_many :taxes, through: :nfces
  has_many :uploads

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name, presence: true
         validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
         validates :password, presence:true, length: { minimum: 6 }


end
