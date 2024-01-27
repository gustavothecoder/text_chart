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

        left_margin = @text_chart.size_config(:bar_margin)
        right_margin = @text_chart.size_config(:bar_margin)
        result += left_margin + right_margin

        bar_width = @text_chart.size_config(:bar_width)
        result += @text_chart.data.size * bar_width

        bar_spacing = @text_chart.size_config(:bar_margin)
        # -1 to avoid adding spacing after the last bar.
        result += (@text_chart.data.size - 1) * bar_spacing

        result
      end
  end

  # @return [Integer]
  def calculate_reference_width
    @reference_width ||=
      begin
        biggest_number_size = @text_chart.data.map(&:to_s).map(&:size).max
        biggest_number_size
      end
  end

  # @return [Integer]
  def calculate_number_of_rows
    @number_of_rows ||=
      begin
        result = 0

        x_axis_row = @text_chart.size_config(:x_axis_height)
        result += x_axis_row

        calculate_bar_height(@text_chart.data.max).times do
          result += @text_chart.size_config(:bar_row_height)
        end

        result
      end
  end

  # @param bar [Integer]
  # @return the number of rows that we should render [Integer]
  def calculate_bar_height(bar)
    return 0 if bar.zero?

    min_bar_height = 1
    (calculate_increase_percentile(@text_chart.data.min, bar) / bar_height_limiter).round + min_bar_height
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

  private

  # @param initial value [Numeric]
  # @param final value [Numeric]
  # @return increase percentile [Float]
  def calculate_increase_percentile(initial, final)
    float_initial = initial.to_f
    float_final = final.to_f
    diff = float_final - float_initial
    (diff / float_initial) * 100.0
  end

  # @return the denominator to assure the `max_rows` config [Integer]
  def bar_height_limiter
    @bar_height_limiter ||=
      begin
        limiter = 10.0
        max_diff = calculate_increase_percentile(@text_chart.data.min, @text_chart.data.max)
        limiter *= 10.0 until (max_diff / limiter).round <= @text_chart.size_config(:max_bar_height)
        limiter
      end
  end
end
