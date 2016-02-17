require 'minitest/autorun'
require 'test/unit'


class CheckerTest < Test::Unit::TestCase
  extend Minitest::Spec::DSL

  describe "Client Base instance initialized wrong" do

    setup do
      @ndc_client = 1
    end
  
    test "Config is wrong" do
      assert true
    end

  end

end
