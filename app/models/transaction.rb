class Transaction < ActiveRecord::Base
  belongs_to :user
  has_many :kinds
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true, length: {maximum:50}
  validates :price, :presence => true,
            :numericality => true,
            :format => { :with => /\A\d{1,4}(\.\d{0,2})?\z/ }

end
