class Currency < ApplicationRecord
	validates :code, uniqueness: true
end
