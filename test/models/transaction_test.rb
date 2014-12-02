require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
 def setup
   @user = users(:Dima)
   @kind = kinds(:internet)
   @transaction = Transaction.new(user_id:@user.id, name:"MyName", price:"3.43", kind_id:@kind.id)
 end

  test "is valid?" do
    assert @transaction.valid?
  end

  test "name should be present" do
    @transaction.name = " "
    assert_not @transaction.valid?
  end
 test "name should not be more than 50char" do
   @transaction.name = "a"*51
   assert_not @transaction.valid?
 end

 test "price should be present, numeric and only2-symbols-after-point" do
   @transaction.price = " " || @transaction.price = "String" || @transaction.price = "3.433"
   assert_not @transaction.valid?
 end

 test "order should be most recent first" do
   assert_equal Transaction.first, transactions(:most_recent)
 end


 test "kind id should be present" do
   @transaction.kind_id = nil
   assert_not @transaction.valid?
 end
 test "user id should be present" do
   @transaction.user_id = nil
   assert_not @transaction.valid?
 end

end
