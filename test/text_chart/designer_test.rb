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

    no_sample_result = no_sample_designer.draw_axis.join
    small_sample_result = small_sample_designer.draw_axis.join

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
  end

  # test "#draw_bars" do
  #   no_sample_designer = TextChart.new("No sample", "Testing", []).designer
  #   sorted_designer = TextChart.new("Sorted", "Testing", [*1..10]).designer
  #   random_order_designer = TextChart.new(
  #     "Random order", "Testing", [*1..10].shuffle(random: Random.new(1))
  #   ).designer

  #   no_sample_result = no_sample_designer.draw_bars.join
  #   sorted_result = sorted_designer.draw_bars.join
  #   random_order_result = random_order_designer.draw_bars.join

  #   expected_no_sample = <<~END

  #   END
  #   assert_equal no_sample_result, expected_no_sample

  #   expected_small_sample = <<~END
  #     10 |
  #        |                                                                                             ###
  #        |                                                                                   ###       ###
  #        |                                                                         ###       ###       ###
  #        |                                                               ###       ###       ###       ###
  #        |                                                     ###       ###       ###       ###       ###
  #      5 |                                           ###       ###       ###       ###       ###       ###
  #        |                                 ###       ###       ###       ###       ###       ###       ###
  #        |                       ###       ###       ###       ###       ###       ###       ###       ###
  #        |             ###       ###       ###       ###       ###       ###       ###       ###       ###
  #        |   ###       ###       ###       ###       ###       ###       ###       ###       ###       ###
  #        |   ###       ###       ###       ###       ###       ###       ###       ###       ###       ###
  #      0 |   ###       ###       ###       ###       ###       ###       ###       ###       ###       ###
  #        ----------------------------------------------------------------------------------------------------
  #   END
  #   assert_equal small_sample_result, expected_small_sample
  # end
end
