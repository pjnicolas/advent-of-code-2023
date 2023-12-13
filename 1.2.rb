file = File.open "1.input", "r"

NumbersList = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

lines_numbers = file.read.lines.map do |line|
  numbers = line.scan(/(?=(\d|zero|one|two|three|four|five|six|seven|eight|nine))/).map { |n| n[0] }

  numbers.map! do |n|
    n.match?(/^\d$/) ? n : NumbersList.find_index(n)
  end

  "#{numbers.first}#{numbers.last}".to_i
end

puts lines_numbers.sum
