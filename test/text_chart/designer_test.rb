# frozen_string_literal: true

require "test_helper"

class TextChart::DesignerTest < Test::Unit::TestCase
  test "#draw_header" do
    text_chart = TextChart.new("This is a nice title", "This is a nice subtitle", [1])

    result = text_chart.designer.draw_header.join

    assert_equal result, <<~EXPECTED
      This is a nice title
      This is a nice subtitle

             
             
    EXPECTED
  end

  test "#draw_axis" do
    small_sample_designer = TextChart.new("Small sample", "Testing", [*1..10]).designer
    with_gaps_designer = TextChart.new("With gaps", "Testing", [1, 5, 10]).designer

    small_sample_result = small_sample_designer.draw_axis.join
    with_gaps_result = with_gaps_designer.draw_axis.join

    assert_equal small_sample_result, <<~END
      10|                                         
       9|                                         
       8|                                         
       7|                                         
       6|                                         
       5|                                         
       4|                                         
       3|                                         
       2|                                         
       1|                                         
        ------------------------------------------
    END
    assert_equal with_gaps_result, <<~END
      10|             
        |             
        |             
        |             
        |             
       5|             
        |             
        |             
        |             
       1|             
        --------------
    END
  end

  test "#draw_bars" do
    sorted_designer = TextChart.new("Sorted", "Testing", [*1..10]).designer
    random_order_designer = TextChart.new(
      "Random order", "Testing", [*1..10].shuffle(random: Random.new(1))
    ).designer
    gaps = TextChart.new(
      "Duplicated and gaps", "Testing", [*1..3, 6, 12].shuffle(random: Random.new(1))
    ).designer

    sorted_result = sorted_designer.draw_bars.join
    random_order_result = random_order_designer.draw_bars.join
    gaps_result = gaps.draw_bars.join

    assert_equal sorted_result, <<-END
                                        ### 
                                    ### ### 
                                ### ### ### 
                            ### ### ### ### 
                        ### ### ### ### ### 
                    ### ### ### ### ### ### 
                ### ### ### ### ### ### ### 
            ### ### ### ### ### ### ### ### 
        ### ### ### ### ### ### ### ### ### 
    ### ### ### ### ### ### ### ### ### ### 
                                            
    END
    assert_equal random_order_result, <<-END
        ###                                 
        ###                         ###     
        ###                     ### ###     
        ### ###                 ### ###     
        ### ###                 ### ### ### 
        ### ### ###             ### ### ### 
        ### ### ###     ###     ### ### ### 
    ### ### ### ###     ###     ### ### ### 
    ### ### ### ###     ### ### ### ### ### 
    ### ### ### ### ### ### ### ### ### ### 
                                            
    END
    assert_equal gaps_result, <<-END
            ###         
            ###         
            ###         
            ###         
            ###         
            ###         
            ###     ### 
            ###     ### 
            ###     ### 
    ###     ###     ### 
    ### ### ###     ### 
    ### ### ### ### ### 
                        
    END
  end
end
