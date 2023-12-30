# frozen_string_literal: true

class TextChart::Designer
  # @param [TextChart] text_chart
  # @param [TextChart::SizeCalculator] size_calc
  # @param [Array<String>] chart_canvas
  def initialize(text_chart, size_calc)
    @text_chart = text_chart
    @size_calc = size_calc
    @chart_canvas = build_empty_chart
  end

  # @return [Array<String>]
  def draw_header
    header = []
    header << "#{@text_chart.title}\n"
    header << "Goal: #{@text_chart.goal}\n"
    header << "\n"

    @chart_canvas.prepend(*header)
  end

  # @return [Array<String>]
  def draw_axis
    draw_x_axis
    draw_y_axis
    draw_references

    @chart_canvas
  end

  # @return [Array<String>]
  def draw_bars
    last_line_index = @chart_canvas.size - 1
    zero_line = last_line_index - @text_chart.size_config(:x_axis_height)
    chart_line = 0
    ref_width = @size_calc.calculate_reference_width
    y_axis_width = @text_chart.size_config(:y_axis_width)
    first_bar_margin = y_axis_width + @text_chart.size_config(:bar_area_left_margin)
    middle_bar_margin = @text_chart.size_config(:bar_spacing)
    bar_row = "###"
    bar_width = @text_chart.size_config(:bar_width)
    bar_start = bar_end = bar_top = 0

    @size_calc.calculate_height_of_bars.each do |height|
      bar_start = if bar_start == 0
        ref_width + first_bar_margin
      else
        # + 1 because bar_end put us on the bar last column
        bar_end + 1 + middle_bar_margin
      end

      # - 1 because bar_start already put us on the bar first column
      bar_end = bar_start + bar_width - 1

      chart_line = zero_line
      bar_top = height - 1
      height.times do |t|
        @chart_canvas[chart_line][bar_start..bar_end] = bar_row

        chart_line -= 1 unless t == bar_top
      end

      draw_reference_line(chart_line, ref_width + y_axis_width, bar_start)
    end

    @chart_canvas
  end

  private

  def build_empty_chart
    chart = []

    number_of_columns = @size_calc.calculate_number_of_columns
    number_of_rows = @size_calc.calculate_number_of_rows

    empty_row = ""
    number_of_columns.times { empty_row += " " }
    empty_row += "\n"

    number_of_rows.times { chart << empty_row.dup }

    chart
  end

  def draw_x_axis
    position = @size_calc.calculate_reference_width
    size = @size_calc.calculate_x_axis_size
    size.times do
      @chart_canvas.last[position] = "-"
      position += 1
    end
  end

  def draw_y_axis
    position = 0
    margin = @size_calc.calculate_reference_width
    size = @size_calc.calculate_y_axis_size
    size.times do
      @chart_canvas[position][margin] = "|"
      position += 1
    end
  end

  def draw_references
    references = @text_chart.refs
    width = @size_calc.calculate_reference_width
    number_of_references = references.size
    ref_size = ref_start = ref_end = nil
    margin_size = @text_chart.size_config(:reference_and_y_axis_margin)

    number_of_references.times do |i|
      ref_size = references[i].size

      if ref_size == (width - margin_size)
        ref_start = 0
        ref_end = ref_size - 1
        @chart_canvas[i][ref_start..ref_end] = references[i]
      else
        ref_start = ref_size
        @chart_canvas[i][ref_start] = references[i]
      end
    end
  end

  def draw_reference_line(chart_line, line_start, line_end)
    current_position = line_start
    until current_position == line_end
      if @chart_canvas[chart_line][current_position] != "#"
        @chart_canvas[chart_line][current_position] = "'"
      end

      current_position += 1
    end
  end
end
