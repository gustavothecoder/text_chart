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
         |                                                                                                   
         |                                                                                                   
       8 |                                                                                                   
         |                                                                                                   
         |                                                                                                   
       6 |                                                                                                   
         |                                                                                                   
         |                                                                                                   
       4 |                                                                                                   
         |                                                                                                   
         |                                                                                                   
       2 |                                                                                                   
         ----------------------------------------------------------------------------------------------------
    END
    assert_equal small_sample_result, expected_small_sample
  end
end
