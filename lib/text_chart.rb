# frozen_string_literal: true

require_relative "text_chart/version"
require_relative "text_chart/size_calculator"
require_relative "text_chart/designer"

# Last 5 races
# Goal: 3km in 16m
# AVG: 13
#
# 18 |'''###
# 17 |   ###
# 16 |   ###
# 15 |'''###'''''''''''''''''''''''''''###
# 14 |   ###                           ###
# 13 |   ###                           ###
# 12 |   ###                           ###
# 11 |   ###                           ###
# 10 |'''###'''''''###'''''''''''''''''###'''''''###
#  9 |'''###'''''''###'''''''###       ###       ###
#  8 |   ###       ###       ###       ###       ###
#  7 |   ###       ###       ###       ###       ###
#  6 |   ###       ###       ###       ###       ###
#  5 |   ###       ###       ###       ###       ###
#  4 |   ###       ###       ###       ###       ###
#  3 |   ###       ###       ###       ###       ###
#  2 |   ###       ###       ###       ###       ###
#  1 |   ###       ###       ###       ###       ###
#  0 |   ###       ###       ###       ###       ###
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
    @refs = define_references
    @size_calculator = SizeCalculator.new(self)
    @designer = Designer.new(self, @size_calculator)
  end

  attr_reader :title, :goal, :refs, :data, :size_calculator, :designer

  # @return [String]
  def to_s
    @designer.draw_axis
    @designer.draw_header.join
  end

  private

  def define_references
    r = @data.sort.reverse
    r << 0 unless r.include?(0)
    r
  end
end
