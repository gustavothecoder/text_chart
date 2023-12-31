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
# 10 |'''''''''###
#  9 |'''''''''###'''''''''''''''''''''''''''''''''''''''###
#  8 |'''''''''###'''''''''''''''''''''''''''''''''###   ###
#  7 |'''''''''###'''###                           ###   ###
#  6 |'''''''''###'''###'''''''''''''''''''''''''''###'''###'''###
#  5 |'''''''''###'''###'''###                     ###   ###   ###
#  4 |'''''''''###'''###'''###'''''''''###         ###   ###   ###
#  3 |'''###   ###   ###   ###         ###         ###   ###   ###
#  2 |'''###'''###'''###'''###'''''''''###'''###   ###   ###   ###
#  1 |'''###'''###'''###'''###'''###   ###   ###   ###   ###   ###
#  0 |   ###   ###   ###   ###   ###   ###   ###   ###   ###   ###
#    ----------------------------------------------------------------
class TextChart
  class Error < StandardError; end

  # @param [String] title
  # @param [String] subtitle
  # @param [Array] data
  # @param [Boolean] colors
  def initialize(title, subtitle, data, colors = false)
    @title = title
    @subtitle = subtitle
    @data = data.empty? ? [0] : data
    @colors = colors
    @refs = define_references
    @size_calculator = SizeCalculator.new(self)
    @designer = Designer.new(self, @size_calculator)
  end

  attr_reader :title, :subtitle, :refs, :data, :size_calculator, :designer

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
    reference_row_height: 1
  }

  def define_references
    r = [*@data.min..@data.max].reverse
    r.map(&:to_s)
  end
end
