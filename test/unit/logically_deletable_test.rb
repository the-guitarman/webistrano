require 'test_helper'

class HostTest < ActiveSupport::TestCase
  test "logical deletion" do
    h = Host.create!(:name => "test.example.com") 
    assert_not_nil h.deleted?

    h.delete_logically
    assert h.deleted?

    deleted = Host.unscoped.find(h.id)
    assert deleted
    assert deleted.deleted?
  end

  test "default scope" do
    hosts = []

    3.times { |i| hosts.push Host.create(name: "test#{i}.example.com") }
    assert_equal Host.all.size, 3

    hosts.first.delete_logically
    assert_equal Host.all.size, 2
  end
end
