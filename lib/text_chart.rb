# frozen_string_literal: true

require_relative "text_chart/version"
require_relative "text_chart/size_calculator"
require_relative "text_chart/designer"

# This is the main class of the text_chart. After calling the `#to_s` method you'll receive a string
# representing the chart, just like this one:
#
# text_chart demonstration
# Show you how cool this is
#
# 73|                                                         ###
#   |                                                         ###
# 67|             ###             ###                         ###         ###
#   |             ###             ###                         ###         ###
# 54|     ###     ###     ###     ###                         ### ###     ###
#   |     ###     ###     ###     ###                         ### ###     ###
# 44|     ### ### ###     ###     ###     ###                 ### ###     ### ###
#   |     ### ### ###     ###     ###     ###                 ### ###     ### ###
# 33|     ### ### ###     ### ### ###     ###                 ### ###     ### ###
#   |     ### ### ###     ### ### ###     ###                 ### ###     ### ###
# 27|     ### ### ### ### ### ### ###     ###         ### ### ### ###     ### ###
# 20|     ### ### ### ### ### ### ###     ###     ### ### ### ### ### ### ### ###
# 14| ### ### ### ### ### ### ### ### ### ###     ### ### ### ### ### ### ### ###
# 10| ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#  5| ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
#   ----------------------------------------------------------------------------------
class TextChart
  class Error < StandardError; end

  # @param [String] title
  # @param [String] subtitle
  # @param [Array] data
  # @param [Boolean] colors
  def initialize(title, subtitle, data, colors = false)
    raise Error, "`data` cannot be empty" if data.empty?

    @title = title
    @subtitle = subtitle
    @data = data.empty? ? [0] : data.filter(&:positive?)
    @colors = colors
    @size_calculator = SizeCalculator.new(self)
    @designer = Designer.new(self, @size_calculator)
  end

  attr_reader :title, :subtitle, :data, :size_calculator, :designer

  # @return [String]
  def to_s
    result = @designer.draw_axis &&
      @designer.draw_bars &&
      @designer.draw_header

    result = @designer.paint if @colors

    result.join
  end

  # @param [Symbol] key
  # @return [Integer]
  def size_config(key)
    SIZE_CONFIG[key]
  end

  private

  SIZE_CONFIG = {
    y_axis_width: 1,
    bar_margin: 1,
    bar_width: 3,
    x_axis_height: 1,
    bar_row_height: 1,
    max_bar_height: 60
  }
end
