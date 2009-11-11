require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "creates an event" do
    my_event = Event.new :item_id => 1,
      :cal_date => Date.today,
      :calibrator_id => 1
    assert my_event.save
  end

  test "should not save event without cal_date" do
    my_event = Event.new :item_id => 1,
      :calibrator_id => 1
    assert !my_event.save
  end

  test "should not save event without calibrator_id" do
    my_event = Event.new :item_id => 1,
      :cal_date => Date.today
    assert !my_event.save
  end
end
