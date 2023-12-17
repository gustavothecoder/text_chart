# frozen_string_literal: true

require "test_helper"

class TextChartTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::TextChart.const_defined?(:VERSION)
    end
  end

  test "#find_references" do
    no_sample = TextChart.new("No sample", "Testing", [])
    small_sample = TextChart.new("Small sample", "Testing", [*1..10])

    no_sample_refs = no_sample.find_references
    small_sample_refs = small_sample.find_references

    assert_equal no_sample_refs, [0]
    assert_equal small_sample_refs, [10, 8, 6, 4, 2]
  end

  # test "text chart with integer values" do
  #   small_sample = TextChart.new("Small sample", "Testing", [*1..5])
  #   # medium_chart = TextChart.new("medium data", [*1..10], "testing")
  #   # big_chart = TextChart.new("big data", [*1..20], "testing")

  #   small_sample_result = small_sample.generate

  #   assert_equal small_sample_result, <<~EXPECTED
  #     Small sample
  #     Goal: Testing

  #     6 |
  #       |                                           5
  #       |                                 4         ###
  #     3 |                       3         ###       ###
  #       |             2         ###       ###       ###
  #       |   1         ###       ###       ###       ###
  #     0 |   ###       ###       ###       ###       ###
  #       --------------------------------------------------
  #   EXPECTED
  # end
end
