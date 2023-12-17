# frozen_string_literal: true

class TextChart::SizeCalculator
  # @param [Array] data
  def initialize(data)
    @data = data
  end

  # @return [Integer]
  def calculate_number_of_columns
    @number_of_columns ||=
      begin
        result = 0

        result += calculate_reference_width

        y_axis_width = 1
        result += y_axis_width

        left_margin = 3
        right_margin = 3
        result += left_margin + right_margin

        bar_width = 3
        result += @data.size * bar_width

        bar_spacing = 7
        # -1 to avoid adding spacing after the last bar.
        result += (@data.size - 1) * bar_spacing

        result
      end
  end

  # @return [Integer]
  def calculate_reference_width
    @reference_width ||=
      begin
        biggest_item = @data.max
        biggest_item_width = biggest_item.digits.count
        reference_margin = 1
        biggest_item_width + reference_margin
      end
  end

  # @return [Integer]
  def calculate_number_of_rows
    @number_of_rows ||=
      begin
        result = 0

        x_axis_row = 1
        result += x_axis_row

        reference_row = 1
        number_of_references = calculate_number_of_references
        number_of_references.times { result += reference_row }

        reference_spacing = 2
        # -1 to avoid spacing after the top reference.
        (number_of_references - 1).times { result += reference_spacing }

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
        x_axis_row = 1
        calculate_number_of_rows - x_axis_row
      end
  end

  # @return [Integer]
  def calculate_number_of_references
    @number_of_references ||= [(@data.size.to_f / 2.0).round, 1].max
  end

  # @return [Integer]
  def calculate_reference_offset
    @reference_offset ||= (@data.max + @data.min) / calculate_number_of_references
  end
end
