class Kind < ActiveRecord::Base
   #belongs_to :transaction
   belongs_to :activity, foreign_key: "transaction_id", class_name: "Transaction"
   default_scope -> { order(created_at: :desc) }
   validates :transaction_id, presence: true
   validates :name, presence: true, length: {maximum:50}
end
