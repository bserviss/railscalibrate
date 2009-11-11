require 'test_helper'

class CalibratorTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should save calibrator" do
    my_calibrator = Calibrator.new :a_name => 'test'
    assert my_calibrator.save
  end

  test "should not save a calibrator without a name" do
    my_calibrator = Calibrator.new
    assert !my_calibrator.save
  end

end
