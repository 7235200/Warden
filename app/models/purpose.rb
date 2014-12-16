class Purpose < ActiveRecord::Base

  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum:50}
  validates :description, length: {maximum:150}
  validates :money, :presence => true,
   :numericality => true,
   :format => { :with => /\A\d{1,8}(\.\d{0,2})?\z/ }
  validates :storage, :presence => true,
   :numericality => true,
   :format => { :with => /\A\d{1,8}(\.\d{0,2})?\z/ }
end
