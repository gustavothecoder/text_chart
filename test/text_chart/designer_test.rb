# frozen_string_literal: true

require "test_helper"

class TextChart::DesignerTest < Test::Unit::TestCase
  test "#draw_header" do
    text_chart = TextChart.new("This is a nice title", "This is a nice goal", [])

    result = text_chart.designer.draw_header.join

    assert_equal result, <<~EXPECTED
      This is a nice title
      Goal: This is a nice goal

                  
                  
    EXPECTED
  end

  test "#draw_axis" do
    no_sample_designer = TextChart.new("No sample", "Testing", []).designer
    small_sample_designer = TextChart.new("Small sample", "Testing", [*1..10]).designer
    with_gaps_designer = TextChart.new("With gaps", "Testing", [1, 5, 10]).designer
    with_negative_number = TextChart.new("With negative number", "Testing", [*-3..3]).designer

    no_sample_result = no_sample_designer.draw_axis.join
    small_sample_result = small_sample_designer.draw_axis.join
    with_gaps_result = with_gaps_designer.draw_axis.join
    with_negative_number_result = with_negative_number.draw_axis.join

    expected_no_sample = <<~END
      0 |         
        ----------
    END
    assert_equal no_sample_result, expected_no_sample

    expected_small_sample = <<~END
      10 |                                                                                                   
       9 |                                                                                                   
       8 |                                                                                                   
       7 |                                                                                                   
       6 |                                                                                                   
       5 |                                                                                                   
       4 |                                                                                                   
       3 |                                                                                                   
       2 |                                                                                                   
       1 |                                                                                                   
       0 |                                                                                                   
         ----------------------------------------------------------------------------------------------------
    END
    assert_equal small_sample_result, expected_small_sample

    expected_with_gaps = <<~END
      10 |                             
       9 |                             
       8 |                             
       7 |                             
       6 |                             
       5 |                             
       4 |                             
       3 |                             
       2 |                             
       1 |                             
       0 |                             
         ------------------------------
    END
    assert_equal with_gaps_result, expected_with_gaps

    expected_with_negative_number = <<~END
       3 |                                                                     
       2 |                                                                     
       1 |                                                                     
       0 |                                                                     
      -1 |                                                                     
      -2 |                                                                     
      -3 |                                                                     
         ----------------------------------------------------------------------
    END
    assert_equal with_negative_number_result, expected_with_negative_number
  end

  test "#draw_bars" do
    sorted_designer = TextChart.new("Sorted", "Testing", [*1..10]).designer
    random_order_designer = TextChart.new(
      "Random order", "Testing", [*1..10].shuffle(random: Random.new(1))
    ).designer
    with_zero_designer = TextChart.new(
      "With zero", "Testing", [*0..5].shuffle(random: Random.new(1))
    ).designer
    gaps = TextChart.new(
      "Duplicated and gaps", "Testing", [*1..3, 6, 12].shuffle(random: Random.new(1))
    ).designer
    negative = TextChart.new(
      "Negative", "Testing", [*-3..3].shuffle(random: Random.new(1))
    ).designer

    sorted_result = sorted_designer.draw_bars.join
    random_order_result = random_order_designer.draw_bars.join
    with_zero_result = with_zero_designer.draw_bars.join
    gaps_result = gaps.draw_bars.join
    negative_result = negative.draw_bars.join

    expected_sorted_result = <<-END
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''###   
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''###       ###   
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''###       ###       ###   
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''###       ###       ###       ###   
    '''''''''''''''''''''''''''''''''''''''''''''''''''''###       ###       ###       ###       ###   
    '''''''''''''''''''''''''''''''''''''''''''###       ###       ###       ###       ###       ###   
    '''''''''''''''''''''''''''''''''###       ###       ###       ###       ###       ###       ###   
    '''''''''''''''''''''''###       ###       ###       ###       ###       ###       ###       ###   
    '''''''''''''###       ###       ###       ###       ###       ###       ###       ###       ###   
    '''###       ###       ###       ###       ###       ###       ###       ###       ###       ###   
       ###       ###       ###       ###       ###       ###       ###       ###       ###       ###   
                                                                                                       
    END
    assert_equal sorted_result, expected_sorted_result

    expected_random_order_result = <<-END
    '''''''''''''###                                                                                   
    '''''''''''''###'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''###             
    '''''''''''''###'''''''''''''''''''''''''''''''''''''''''''''''''''''''''###       ###             
    '''''''''''''###'''''''###                                               ###       ###             
    '''''''''''''###'''''''###'''''''''''''''''''''''''''''''''''''''''''''''###'''''''###'''''''###   
    '''''''''''''###'''''''###'''''''###                                     ###       ###       ###   
    '''''''''''''###'''''''###'''''''###'''''''''''''''''###                 ###       ###       ###   
    '''###       ###       ###       ###                 ###                 ###       ###       ###   
    '''###'''''''###'''''''###'''''''###'''''''''''''''''###'''''''###       ###       ###       ###   
    '''###'''''''###'''''''###'''''''###'''''''###       ###       ###       ###       ###       ###   
       ###       ###       ###       ###       ###       ###       ###       ###       ###       ###   
                                                                                                       
    END
    assert_equal random_order_result, expected_random_order_result

    expected_with_zero_result = <<-END
   '''''''''''''''''''''''''''''''''''''''''''''''''''''###   
   '''''''''''''''''''''''###                           ###   
   '''''''''''''''''''''''###'''''''''''''''''###       ###   
   '''###                 ###                 ###       ###   
   '''###'''''''###       ###                 ###       ###   
   '''###'''''''###'''''''###'''''''###       ###       ###   
                                                              
    END
    assert_equal with_zero_result, expected_with_zero_result

    expected_gaps_result = <<-END
    '''''''''''''''''''''''###                       
                           ###                       
                           ###                       
                           ###                       
                           ###                       
                           ###                       
    '''''''''''''''''''''''###'''''''''''''''''###   
                           ###                 ###   
                           ###                 ###   
    '''###                 ###                 ###   
    '''###'''''''###       ###                 ###   
    '''###'''''''###'''''''###'''''''###       ###   
       ###       ###       ###       ###       ###   
                                                     
    END
    assert_equal gaps_result, expected_gaps_result

    expected_negative_result = <<-END
    '''###                                                               
    '''###'''''''''''''''''''''''''''''''''''''''''''''''''''''''''###   
    '''###'''''''''''''''''''''''''''''''''''''###                 ###   
    '''###'''''''''''''''''''''''''''''''''''''###'''''''###       ###   
    '''###'''''''###                           ###       ###       ###   
    '''###'''''''###'''''''###                 ###       ###       ###   
    '''###'''''''###'''''''###'''''''###       ###       ###       ###   
                                                                         
    END
    assert_equal negative_result, expected_negative_result
  end
end
