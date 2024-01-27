# frozen_string_literal: true

require "test_helper"

class TextChart::SizeCalculatorTest < Test::Unit::TestCase
  test "#calculate_reference_width" do
    small_sample = TextChart.new("", "", [*1..10]).size_calculator
    medium_sample = TextChart.new("", "", [*1..100]).size_calculator
    big_sample = TextChart.new("", "", [*1..1000]).size_calculator

    small_sample_result = small_sample.calculate_reference_width
    medium_sample_result = medium_sample.calculate_reference_width
    big_sample_result = big_sample.calculate_reference_width

    assert_equal small_sample_result, 2
    assert_equal medium_sample_result, 3
    assert_equal big_sample_result, 4
  end

  test "#calculate_number_of_rows" do
    sequencial_sample = TextChart.new("", "", [*1..10]).size_calculator
    small_gaps_sample = TextChart.new(
      "",
      "",
      [16, 1, 18, 24, 7, 10, 5, 16, 7, 15]
    ).size_calculator
    medium_gaps_sample = TextChart.new(
      "",
      "",
      [36, 34, 15, 18, 37, 18, 16, 12, 26, 9]
    ).size_calculator

    sequencial_sample_result = sequencial_sample.calculate_number_of_rows
    small_gaps_result = small_gaps_sample.calculate_number_of_rows
    medium_gaps_result = medium_gaps_sample.calculate_number_of_rows

    # Example:
    # 10|      1
    #  9|      2
    #  8|      3
    #  7|      4
    #  6|      5
    #  5|      6
    #  4|      7
    #  3|      8
    #  2|      9
    #  1|      10
    #   ------ 11
    assert_equal sequencial_sample_result, 11
    # Example:
    # 24|      1
    #   |      2
    #   |      3
    #   |      4
    #   |      5
    #   |      6
    # 18|      7
    #   |      8
    # 16|      9
    # 15|      10
    #   |      11
    #   |      12
    #   |      13
    #   |      14
    # 10|      15
    #   |      16
    #   |      17
    #  7|      18
    #   |      19
    #  5|      20
    #   |      21
    #   |      22
    #   |      23
    #  1|      24
    #   ------ 25
    assert_equal small_gaps_result, 25
    # Example:
    # 37|      1
    # 36|      2
    #   |      3
    # 34|      4
    #   |      5
    #   |      6
    #   |      7
    #   |      8
    #   |      9
    #   |      10
    #   |      11
    #   |      12
    # 26|      13
    #   |      14
    #   |      15
    #   |      16
    #   |      17
    #   |      18
    #   |      19
    #   |      20
    #   |      21
    # 18|      22
    #   |      23
    # 16|      24
    # 15|      25
    #   |      26
    #   |      27
    #   |      28
    # 12|      29
    #   |      30
    #   |      31
    #  9|      32
    #   ------ 33
    assert_equal medium_gaps_result, 33
  end

  test "#calculate_number_of_columns" do
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    small_sample_result = small_sample.calculate_number_of_columns

    # Example:
    # 10|
    #  .
    #  .
    #  .
    #  2| ### ### ### ### ### ### ### ### ### ###
    #   ------------------------------------------
    # cccccccccccccccccccccccccccccccccccccccccccc = 44
    assert_equal small_sample_result, 44
  end

  test "#calculate_x_axis_size" do
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    small_sample_result = small_sample.calculate_x_axis_size

    # Example:
    # 10|
    #  .
    #  .
    #  .
    #  2| ### ### ### ### ### ### ### ### ### ###
    #   ------------------------------------------
    #   cccccccccccccccccccccccccccccccccccccccccc = 42
    assert_equal small_sample_result, 42
  end

  test "#calculate_y_axis_size" do
    small_sample = TextChart.new("", "", [*1..10]).size_calculator

    small_sample_result = small_sample.calculate_y_axis_size

    # Example:
    # 10|     y
    #  9|     y
    #  8|     y
    #  7|     y
    #  6|     y
    #  5|     y
    #  4|     y
    #  3|     y
    #  2|     y
    #  1|     y = 10
    #   ------
    assert_equal small_sample_result, 10
  end
end
