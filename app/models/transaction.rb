class Transaction < ActiveRecord::Base
  self.inheritance_column = nil
  validates :name, presence: true, length: { maximum: 50 }
  validates :price, :presence => true,
            :numericality => true,
            :format => { :with => /\A\d{1,4}(\.\d{0,2})?\z/ }
  validates :type, presence: true
end
