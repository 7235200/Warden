class Kind < ActiveRecord::Base
   #belongs_to :transaction
   has_many :activity, foreign_key: "transaction_id", class_name: "Transaction"
   default_scope -> { order(created_at: :desc) }
   validates :name, presence: true, length: {maximum:50}
end
