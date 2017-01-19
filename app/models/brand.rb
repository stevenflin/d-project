class Brand < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :creators
end
