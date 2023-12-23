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

  # TODO
  # def draw_bars

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
end
