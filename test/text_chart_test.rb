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
    sorted_sample = TextChart.new("Sorted sample", "Testing", [*5..10])
    random_order_sample = TextChart.new(
      "Random order sample", "Testing", [*1..10].shuffle(random: Random.new(1))
    )
    duplicated_and_gaps = TextChart.new(
      "Duplicated and gaps sample", "Testing", [*0..3, 3, 6, 12].shuffle(random: Random.new(1))
    )
    with_negative_numbers = TextChart.new(
      "With negative numbers sample", "Testing", [*-3..3].shuffle(random: Random.new(1))
    )
    with_colors = TextChart.new(
      "With colors", "Testing", [*-3..3].shuffle(random: Random.new(1)), true
    )

    no_sample_result = no_sample.to_s
    sorted_result = sorted_sample.to_s
    random_order_result = random_order_sample.to_s
    duplicated_and_gaps_result = duplicated_and_gaps.to_s
    with_negative_numbers_result = with_negative_numbers.to_s
    with_colors_result = with_colors.to_s

    assert_equal no_sample_result, <<~EXPECTED
      No sample
      Testing

      0 |'''###   
        ----------
    EXPECTED
    assert_equal sorted_result, <<~EXPECTED
      Sorted sample
      Testing

      10 |'''''''''''''''''''''''''''''''''###   
       9 |'''''''''''''''''''''''''''###   ###   
       8 |'''''''''''''''''''''###   ###   ###   
       7 |'''''''''''''''###   ###   ###   ###   
       6 |'''''''''###   ###   ###   ###   ###   
       5 |'''###   ###   ###   ###   ###   ###   
         ----------------------------------------
    EXPECTED
    assert_equal random_order_result, <<~EXPECTED
      Random order sample
      Testing

      10 |'''''''''###                                                   
       9 |'''''''''###'''''''''''''''''''''''''''''''''''''''###         
       8 |'''''''''###'''''''''''''''''''''''''''''''''###   ###         
       7 |'''''''''###'''###                           ###   ###         
       6 |'''''''''###'''###'''''''''''''''''''''''''''###'''###'''###   
       5 |'''''''''###'''###'''###                     ###   ###   ###   
       4 |'''''''''###'''###'''###'''''''''###         ###   ###   ###   
       3 |'''###   ###   ###   ###         ###         ###   ###   ###   
       2 |'''###'''###'''###'''###'''''''''###'''###   ###   ###   ###   
       1 |'''###'''###'''###'''###'''###   ###   ###   ###   ###   ###   
         ----------------------------------------------------------------
    EXPECTED
    assert_equal duplicated_and_gaps_result, <<~EXPECTED
      Duplicated and gaps sample
      Testing

      12 |'''###                                       
      11 |   ###                                       
      10 |   ###                                       
       9 |   ###                                       
       8 |   ###                                       
       7 |   ###                                       
       6 |'''###'''''''''''''''''''''''''''''''''###   
       5 |   ###                                 ###   
       4 |   ###                                 ###   
       3 |'''###'''''''''''''''''''''###'''###   ###   
       2 |'''###'''###               ###   ###   ###   
       1 |'''###'''###'''###         ###   ###   ###   
       0 |'''###'''###'''###'''###   ###   ###   ###   
         ----------------------------------------------
    EXPECTED
    assert_equal with_negative_numbers_result, <<~EXPECTED
      With negative numbers sample
      Testing

       3 |'''###                                       
       2 |'''###'''''''''''''''''''''''''''''''''###   
       1 |'''###'''''''''''''''''''''###         ###   
       0 |'''###'''''''''''''''''''''###'''###   ###   
      -1 |'''###'''###               ###   ###   ###   
      -2 |'''###'''###'''###         ###   ###   ###   
      -3 |'''###'''###'''###'''###   ###   ###   ###   
         ----------------------------------------------
    EXPECTED
    assert_equal with_colors_result, <<~EXPECTED
      \e[1mWith colors\e[22m
      Testing

       \e[36m3\e[0m |\e[36m'''\e[0m\e[34m###\e[0m                                       
       \e[36m2\e[0m |\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''''''''''''''''''''''''''''''''\e[0m\e[34m###\e[0m   
       \e[36m1\e[0m |\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''''''''''''''''''''\e[0m\e[34m###\e[0m         \e[34m###\e[0m   
       \e[36m0\e[0m |\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''''''''''''''''''''\e[0m\e[34m###\e[0m\e[36m'''\e[0m\e[34m###\e[0m   \e[34m###\e[0m   
      \e[36m-1\e[0m |\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''\e[0m\e[34m###\e[0m               \e[34m###\e[0m   \e[34m###\e[0m   \e[34m###\e[0m   
      \e[36m-2\e[0m |\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''\e[0m\e[34m###\e[0m         \e[34m###\e[0m   \e[34m###\e[0m   \e[34m###\e[0m   
      \e[36m-3\e[0m |\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''\e[0m\e[34m###\e[0m\e[36m'''\e[0m\e[34m###\e[0m   \e[34m###\e[0m   \e[34m###\e[0m   \e[34m###\e[0m   
         ----------------------------------------------
    EXPECTED
  end
end
