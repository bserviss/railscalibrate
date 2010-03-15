require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  test "creates an issue" do
    my_issue = Issue.new :item_id => 1,
      :description => 'Test'
    assert my_issue.save
  end
end
