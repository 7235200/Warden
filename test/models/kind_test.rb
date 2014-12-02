require 'test_helper'

class KindTest < ActiveSupport::TestCase

  def setup
    @transaction = transactions(:internet)
    #@kind = Kind.new(transaction_id:@transaction.id, name:"Internet")
    @kind = @transaction.kinds.build(name:"Internet")
  end

  test "is valid?" do
    assert @kind.valid?
  end

  test "transaction id should be present" do
    @kind.transaction_id = nil
    assert_not @kind.valid?
  end

  test "name should be present " do
    @kind.name = "   "
    assert_not @kind.valid?
  end

  test "name should be at most 50 characters" do
    @kind.name = "a" * 51
    assert_not @kind.valid?
  end

  test "order should be most recent first" do
    assert_equal Kind.first, kinds(:most_recent)
  end

end
