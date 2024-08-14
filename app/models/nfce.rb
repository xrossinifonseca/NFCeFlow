class Nfce < ApplicationRecord
  belongs_to :customer
  belongs_to :issuer
  belongs_to :recipient
  has_one :tax
  has_many :nfce_products, dependent: :destroy
  has_many :products, through: :nfce_products

  validates :data_emissao, presence: true
  validates :numero_nota, presence: true
  validates :serie, presence: true







end
