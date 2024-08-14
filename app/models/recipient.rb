class Recipient < ApplicationRecord
  has_many :nfce, dependent: :destroy

end
