class Issuer < ApplicationRecord
  has_many :nfce, dependent: :destroy

  validates :cnpj, presence: true, uniqueness: true



end
