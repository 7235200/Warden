require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = Transaction.new(user_id:"1", name:"Playstation4", price:"195.34", type:"Other")
  end

  test "should be valid" do
    assert @transaction.valid?
  end
  test "name should be present" do
    @transaction.name = " "
    assert_not @transaction.valid?
  end
  test "price should be present numeric and only-2symbols-after-point" do
    @transaction.price = " " || @transaction.price = "number" || @transaction.price = "3.333"
    assert_not @transaction.valid?
  end
  test "type should be present" do
    @transaction.type = " "
    assert_not @transaction.valid?
  end
  test "name should not be too long" do
    @transaction.name = "a" * 51
    assert_not @transaction.valid?
  end

end
