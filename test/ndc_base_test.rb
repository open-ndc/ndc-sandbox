require 'test_helper'

class NDCBaseTest < Test::Unit::TestCase
  extend Minitest::Spec::DSL

  describe "Base test initialized wrong" do
    test "Config is wrong" do
      assert 1+1==1
    end
  end

  describe "Base test initialized OK" do
    test "Config is OK" do
      assert 1+1==2
    end
  end
end
