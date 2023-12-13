class ControlPanel
  attr :grid, :height, :width

  def initialize(str)
    @grid = str.lines.map { |line| line.split('') }
    @height = @grid.length
    @width = @grid[0].length
  end

  def has_special_character?(str)
    str.match?(/[^.\d\n]/)
  end

  def surrounded_by_special?(line_number, column_start, column_end)
    surroundings = ""

    has_space_up = line_number > 0
    has_space_down = line_number < (@height - 1)
    has_space_left = column_start > 0
    has_space_right = column_end < (@width - 1)
    left_offset = has_space_left ? -1 : 0
    right_offset = has_space_right ? 1 : 0

    # Checks up, down, left, and right in the grid
    surroundings << @grid[line_number - 1][(column_start + left_offset)..(column_end + right_offset)].join('') if has_space_up
    surroundings << @grid[line_number + 1][(column_start + left_offset)..(column_end + right_offset)].join('') if has_space_down
    surroundings << @grid[line_number][column_start - 1] if has_space_left
    surroundings << @grid[line_number][column_end + 1] if has_space_right

    has_special_character? surroundings
  end

  def get_result()
    numbers = @grid.each_with_index.map do | line, lineIndex |
      start_index = 0
      number_text = nil
      number_array = []

      line.each_with_index do | char, charIndex |
        if char.match?(/\d/)
          if number_text == nil
            start_index = charIndex
            number_text = char
          else
            number_text << char
          end
        else
          if number_text != nil
            if surrounded_by_special?(lineIndex, start_index, charIndex - 1)
              number_array << number_text.to_i
            end

            number_text = nil
          end
        end
      end

      number_array
    end

    result = numbers.map{ |row| row.sum }.sum
  end
end

file = File.open "3.input", "r"
control_panel = ControlPanel.new file.read
puts control_panel.get_result
