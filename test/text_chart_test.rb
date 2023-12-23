# frozen_string_literal: true

require "test_helper"

class TextChartTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::TextChart.const_defined?(:VERSION)
    end
  end

  test "#to_s" do
    no_sample = TextChart.new("No sample", "Testing", [])
    small_sample = TextChart.new("Small sample", "Testing", [*1..5])

    no_sample_result = no_sample.to_s
    small_sample_result = small_sample.to_s

    assert_equal no_sample_result, <<~EXPECTED
      No sample
      Goal: Testing

      0 |         
        ----------
    EXPECTED
    assert_equal small_sample_result, <<~EXPECTED
      Small sample
      Goal: Testing

      5 |                                                 
      4 |                                                 
      3 |                                                 
      2 |                                                 
      1 |                                                 
      0 |                                                 
        --------------------------------------------------
    EXPECTED
  end
end
