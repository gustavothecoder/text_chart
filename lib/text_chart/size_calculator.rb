# frozen_string_literal: true

class TextChart::SizeCalculator
  # @param [TextChart] text_chart
  def initialize(text_chart)
    @text_chart = text_chart
  end

  # @return [Integer]
  def calculate_number_of_columns
    @number_of_columns ||=
      begin
        result = 0

        result += calculate_reference_width

        y_axis_width = @text_chart.size_config(:y_axis_width)
        result += y_axis_width

        left_margin = @text_chart.size_config(:bar_area_left_margin)
        right_margin = @text_chart.size_config(:bar_area_right_margin)
        result += left_margin + right_margin

        bar_width = @text_chart.size_config(:bar_width)
        result += @text_chart.data.size * bar_width

        bar_spacing = @text_chart.size_config(:bar_spacing)
        # -1 to avoid adding spacing after the last bar.
        result += (@text_chart.data.size - 1) * bar_spacing

        result
      end
  end

  # @return [Integer]
  def calculate_reference_width
    @reference_width ||=
      begin
        biggest_item = @text_chart.data.max
        biggest_item_width = biggest_item.digits.count
        reference_margin = @text_chart.size_config(:reference_and_y_axis_margin)
        biggest_item_width + reference_margin
      end
  end

  # @return [Integer]
  def calculate_number_of_rows
    @number_of_rows ||=
      begin
        result = 0

        x_axis_row = @text_chart.size_config(:x_axis_height)
        result += x_axis_row

        reference_row = @text_chart.size_config(:reference_row_height)
        number_of_references = @text_chart.refs.size
        number_of_references.times { result += reference_row }

        result
      end
  end

  # @return [Integer]
  def calculate_x_axis_size
    @x_axis_size ||= calculate_number_of_columns - calculate_reference_width
  end

  # @return [Integer]
  def calculate_y_axis_size
    @y_axis_size ||=
      begin
        x_axis_row = @text_chart.size_config(:x_axis_height)
        calculate_number_of_rows - x_axis_row
      end
  end
end
