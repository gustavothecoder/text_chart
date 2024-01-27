# frozen_string_literal: true

require "test_helper"

class TextChartTest < Test::Unit::TestCase
  test "VERSION" do
    assert do
      ::TextChart.const_defined?(:VERSION)
    end
  end

  test "#initialize" do
    assert_raise_message("`data` cannot be empty") { TextChart.new("Title", "Subtitle", []) }
  end

  test "#to_s" do
    sorted_sample = TextChart.new("Sorted sample", "Testing", [*5..10])
    random_order_sample = TextChart.new(
      "Random order sample", "Testing", [*1..10].shuffle(random: Random.new(1))
    )
    duplicated_and_gaps = TextChart.new(
      "Duplicated and gaps sample", "Testing", [*0..3, 3, 6, 12].shuffle(random: Random.new(1))
    )
    with_colors = TextChart.new(
      "With colors", "Testing", [*0..3, 3, 6, 12].shuffle(random: Random.new(1)), true
    )
    nearby_numbers = TextChart.new(
      "Nearby numbers", "Numbers between 90 and 120", [116, 114, 115, 102, 104, 96, 103, 113, 119, 94]
    )

    sorted_result = sorted_sample.to_s
    random_order_result = random_order_sample.to_s
    duplicated_and_gaps_result = duplicated_and_gaps.to_s
    with_colors_result = with_colors.to_s
    nearby_numbers_result = nearby_numbers.to_s

    assert_equal sorted_result, <<~EXPECTED
      Sorted sample
      Testing

      10|                     ### 
        |                     ### 
       9|                 ### ### 
        |                 ### ### 
       8|             ### ### ### 
        |             ### ### ### 
       7|         ### ### ### ### 
        |         ### ### ### ### 
       6|     ### ### ### ### ### 
        |     ### ### ### ### ### 
       5| ### ### ### ### ### ### 
        --------------------------
    EXPECTED
    assert_equal random_order_result, <<~EXPECTED
      Random order sample
      Testing

      10|     ###                                 
       9|     ###                         ###     
       8|     ###                     ### ###     
       7|     ### ###                 ### ###     
       6|     ### ###                 ### ### ### 
       5|     ### ### ###             ### ### ### 
       4|     ### ### ###     ###     ### ### ### 
       3| ### ### ### ###     ###     ### ### ### 
       2| ### ### ### ###     ### ### ### ### ### 
       1| ### ### ### ### ### ### ### ### ### ### 
        ------------------------------------------
    EXPECTED
    assert_equal duplicated_and_gaps_result, <<~EXPECTED
      Duplicated and gaps sample
      Testing

      12| ###                     
        | ###                     
        | ###                     
        | ###                     
        | ###                     
        | ###                     
       6| ###                 ### 
        | ###                 ### 
        | ###                 ### 
       3| ###         ### ### ### 
       2| ### ###     ### ### ### 
       1| ### ### ### ### ### ### 
        --------------------------
    EXPECTED
    assert_equal with_colors_result, <<~EXPECTED
      \e[1mWith colors\e[22m
      Testing
      
      \e[36m1\e[0m\e[36m2\e[0m| \e[34m###\e[0m                     
        | \e[34m###\e[0m                     
        | \e[34m###\e[0m                     
        | \e[34m###\e[0m                     
        | \e[34m###\e[0m                     
        | \e[34m###\e[0m                     
       \e[36m6\e[0m| \e[34m###\e[0m                 \e[34m###\e[0m 
        | \e[34m###\e[0m                 \e[34m###\e[0m 
        | \e[34m###\e[0m                 \e[34m###\e[0m 
       \e[36m3\e[0m| \e[34m###\e[0m         \e[34m###\e[0m \e[34m###\e[0m \e[34m###\e[0m 
       \e[36m2\e[0m| \e[34m###\e[0m \e[34m###\e[0m     \e[34m###\e[0m \e[34m###\e[0m \e[34m###\e[0m 
       \e[36m1\e[0m| \e[34m###\e[0m \e[34m###\e[0m \e[34m###\e[0m \e[34m###\e[0m \e[34m###\e[0m \e[34m###\e[0m 
        --------------------------
    EXPECTED
    # [116, 114, 115, 102, 104, 96, 103, 113, 119, 94]
    assert_equal nearby_numbers_result, <<~EXPECTED
      Nearby numbers
      Numbers between 90 and 120

      119|                                 ###     
      113| ### ### ###                 ### ###     
      103| ### ### ### ### ###     ### ### ###     
       94| ### ### ### ### ### ### ### ### ### ### 
         ------------------------------------------
    EXPECTED
  end
end
