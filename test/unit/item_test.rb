require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  test "should create item" do
    my_item = Item.new :description => 'test',
      :org_sn => '1234',
      :pn => 'test',
      :cal_cycle_days => 365
    assert my_item.save
  end

  test "should not create item without pn" do
    my_item = Item.new :description => 'test',
      :org_sn => '1234',
      :cal_cycle_days => 365
    assert ! my_item.save
  end

  test "should not create item without description" do
    my_item = Item.new :org_sn => '1234',
      :cal_cycle_days => 365,
      :pn => 'test'
    assert ! my_item.save
  end

  test "should not create item without org_sn" do
    my_item = Item.new :description => 'test',
      :pn => 'test',
      :cal_cycle_days => 365
    assert !my_item.save
  end

  test "should not create item without cal_cycle_days" do
    my_item = Item.new :description => 'test',
      :pn => 'test'
    assert !my_item.save
  end

end