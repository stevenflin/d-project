class User < ApplicationRecord
	has_one :agency
	has_one :brand
	has_one :creator
end
