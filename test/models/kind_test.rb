require 'test_helper'

class KindTest < ActiveSupport::TestCase

  def setup
    @kind = kinds(:internet)
  end

  test "is valid?" do
    assert @kind.valid?
  end

  test "name should be present " do
    @kind.name = "   "
    assert_not @kind.valid?
  end

  test "name should be at most 50 characters" do
    @kind.name = "a" * 51
    assert_not @kind.valid?
  end

end
