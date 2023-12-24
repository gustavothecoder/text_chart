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
    zero_line = @chart_canvas.size - 2
    chart_line = 0
    ref_width = @size_calc.calculate_reference_width
    y_axis_width = 1
    first_bar_margin = 4
    middle_bar_margin = 8
    bar_row = "###"
    bar_width = 2
    bar_height = bar_start = bar_end = bar_top = 0

    @text_chart.data.each do |d|
      # + 1 to guarantee that the bar will always be rendered
      bar_height = d + 1

      bar_start = if bar_start == 0
        ref_width + first_bar_margin
      else
        bar_end + middle_bar_margin
      end

      bar_end = bar_start + bar_width

      chart_line = zero_line
      bar_top = bar_height - 1
      bar_height.times do |t|
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
    margin_size = 1

    number_of_references.times do |i|
      ref_size = references[i].digits.size

      if ref_size == (width - margin_size)
        ref_start = 0
        ref_end = ref_size - 1
        @chart_canvas[i][ref_start..ref_end] = references[i].to_s
      else
        ref_start = ref_size
        @chart_canvas[i][ref_start] = references[i].to_s
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
