# frozen_string_literal: true

require_relative "text_chart/version"
require_relative "text_chart/size_calculator"
require_relative "text_chart/designer"

# Last 5 races
# Goal: 3km in 16m
# AVG: 13m
#
# 20m |
#     |   18m34s
#     |   ###                           15m23s
# 10m |   ###       10m09s              ###       10m33s
#     |   ###       ###       9m33s     ###       ###
#     |   ###       ###       ###       ###       ###
#  0m |...###.......###.......###.......###.......###...
#     --------------------------------------------------
#
# Requirements:
# 1. The "Last 5 races" should be a customizable string;
# 2. The "Goal" should be a customizable string;
# 3. The "AVG" should consider only the displayed data;
# 4. The chart should support time, integers and floats;
# 5. The y axi should change based on the highest value.

class TextChart
  class Error < StandardError; end

  # @param [String] title
  # @param [String] goal
  # @param [Array] data
  def initialize(title, goal, data)
    @title = title
    @goal = goal
    @data = data.empty? ? [0] : data
    @size_calculator = SizeCalculator.new(@data)
    @designer = Designer.new(self, @size_calculator)
  end

  attr_reader :title, :goal, :size_calculator, :designer

  # @return [Array<Integer>]
  def find_references
    number_of_refs = @size_calculator.calculate_number_of_references
    ref_offset = @size_calculator.calculate_reference_offset

    refs = [@data.max]
    (number_of_refs - 1).times do
      refs << refs.last - ref_offset
    end

    refs
  end

  # @return [String]
  def to_s
    @designer.draw_header
    @designer.draw_axis.join
  end
end
