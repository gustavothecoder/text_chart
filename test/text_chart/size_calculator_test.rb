# frozen_string_literal: true

require "test_helper"

class TextChart::SizeCalculatorTest < Test::Unit::TestCase
  test "#calculate_reference_width" do
    no_sample = TextChart.new("", "", []).size_calculator
    small_sample = TextChart.new("", "", [*1..10]).size_calculator
    medium_sample = TextChart.new("", "", [*1..100]).size_calculator
    big_sample = TextChart.new("", "", [*1..1000]).size_calculator

    no_sample_result = no_sample.calculate_reference_width
    small_sample_result = small_sample.calculate_reference_width
    medium_sample_result = medium_sample.calculate_reference_width
    big_sample_result = big_sample.calculate_reference_width

    assert_equal no_sample_result, 2
    assert_equal small_sample_result, 3
    assert_equal medium_sample_result, 4
    assert_equal big_sample_result, 5
  end

  test "#calculate_number_of_rows" do
    no_sample = TextChart.new("", "", []).size_calculator
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    no_sample_result = no_sample.calculate_number_of_rows
    small_sample_result = small_sample.calculate_number_of_rows

    # Example:
    # 0 |          1
    #   ---------- 2
    assert_equal no_sample_result, 2

    # Example:
    # 10 |       1
    #    |       2
    #    |       3
    #  8 |       4
    #    |       5
    #    |       6
    #  6 |       7
    #    |       8
    #    |       9
    #  4 |       10
    #    |       11
    #    |       12
    #  2 |       13
    #    ------- 14
    assert_equal small_sample_result, 14
  end

  test "#calculate_number_of_columns" do
    no_sample = TextChart.new("", "", []).size_calculator
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    no_sample_result = no_sample.calculate_number_of_columns
    small_sample_result = small_sample.calculate_number_of_columns

    # Example:
    # 0 |
    #   ----------
    # cccccccccccc = 12
    assert_equal no_sample_result, 12

    # Example:
    # 10 |
    #  .
    #  .
    #  .
    #  2 |   ###       ###       ###       ###       ###       ###       ###       ###       ###       ###
    #    ----------------------------------------------------------------------------------------------------
    # ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc = 103
    assert_equal small_sample_result, 103
  end

  test "#calculate_x_axis_size" do
    no_sample = TextChart.new("", "", []).size_calculator
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    no_sample_result = no_sample.calculate_x_axis_size
    small_sample_result = small_sample.calculate_x_axis_size

    # Example:
    # 0 |
    #   ----------
    #   xxxxxxxxxx = 10
    assert_equal no_sample_result, 10

    # Example:
    # 10 |
    #  .
    #  .
    #  .
    #  2 |   ###       ###       ###       ###       ###       ###       ###       ###       ###       ###
    #    ----------------------------------------------------------------------------------------------------
    #    cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc = 100
    assert_equal small_sample_result, 100
  end

  test "#calculate_y_axis_size" do
    no_sample = TextChart.new("", "", []).size_calculator
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    no_sample_result = no_sample.calculate_y_axis_size
    small_sample_result = small_sample.calculate_y_axis_size

    # Example:
    # 0 |         y = 1
    #   ----------
    assert_equal no_sample_result, 1

    # Example:
    # 10 |         y
    #    |         y
    #    |         y
    #  8 |         y
    #    |         y
    #    |         y
    #  6 |         y
    #    |         y
    #    |         y
    #  4 |         y
    #    |         y
    #    |         y
    #  2 |         y = 13
    #    ----------
    assert_equal small_sample_result, 13
  end

  test "#calculate_reference_offset" do
    no_sample = TextChart.new("", "", []).size_calculator
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    no_sample_result = no_sample.calculate_reference_offset
    small_sample_result = small_sample.calculate_reference_offset

    assert_equal no_sample_result, 0
    assert_equal small_sample_result, 2
  end
end