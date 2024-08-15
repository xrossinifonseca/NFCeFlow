class Product < ApplicationRecord
  has_many :nfce_products, dependent: :destroy
  has_many :nfces, through: :nfce_products

  validates :nome, uniqueness: {scope: [:ncm, :cfop]}

end
