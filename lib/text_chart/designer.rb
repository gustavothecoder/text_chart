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
    header << "#{@text_chart.subtitle}\n"
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
    bar_margin = @text_chart.size_config(:bar_margin)
    bar_row = "###"
    bar_width = @text_chart.size_config(:bar_width)
    bar_start = bar_end = bar_top = 0
    height_of_bars = define_height_of_bars

    height_of_bars.each do |height|
      bar_start = if bar_start == 0
        ref_width + bar_margin + y_axis_width
      else
        # + 1 because bar_end put us on the bar last column
        bar_end + 1 + bar_margin
      end

      # - 1 because bar_start already put us on the bar first column
      bar_end = bar_start + bar_width - 1

      chart_line = zero_line
      bar_top = height - 1
      height.times do |t|
        @chart_canvas[chart_line][bar_start..bar_end] = bar_row

        chart_line -= 1 unless t == bar_top
      end
    end

    @chart_canvas
  end

  # @return [Array<String>]
  def paint
    @chart_canvas.map do |row|
      next if row.gsub!(@text_chart.title, colorize(@text_chart.title, :bold))

      row.gsub!(/-?\d/) { colorize($&, :cyan) }
      row.gsub!(/#+/) { colorize($&, :blue) }
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
    references = @text_chart.data
    width = @size_calc.calculate_reference_width
    y_axis_size = @size_calc.calculate_y_axis_size
    ref_size = ref_start = ref_end = ref_str = nil

    references.each do |r|
      row = y_axis_size - @size_calc.calculate_bar_height(r)
      ref_str = r.to_s
      ref_size = ref_str.size

      if ref_size == width
        ref_start = 0
        ref_end = ref_size - 1
      else
        ref_start = width - ref_size
        ref_end = [ref_start, ref_size].max
      end
      @chart_canvas[row][ref_start..ref_end] = ref_str
    end
  end

  # @param string to be colorized [String]
  # @param desired color/formatting [Symbol]
  # @return colorized string [String]
  def colorize(str, format)
    case format
    when :bold
      "\e[1m#{str}\e[22m"
    when :cyan
      "\e[36m#{str}\e[0m"
    when :blue
      "\e[34m#{str}\e[0m"
    end
  end

  # @return height of each sample item [Array<Integer>]
  def define_height_of_bars
    @text_chart.data.map { |i| @size_calc.calculate_bar_height(i) }
  end
end
