class Recipient < ApplicationRecord
  has_many :nfces, dependent: :destroy

  validates :cnpj, presence: true, uniqueness: true


end
