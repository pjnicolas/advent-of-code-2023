file = File.open "2.input", "r"

MAX_RED = 12
MAX_GREEN = 13
MAX_BLUE = 14

games = file.read.lines.map do |line|
  {
    n: line.match(/Game (\d+):/)[1].to_i,
    red: line.scan(/(\d+) red/).map{|e| e[0].to_i}.max,
    green: line.scan(/(\d+) green/).map{|e| e[0].to_i}.max,
    blue: line.scan(/(\d+) blue/).map{|e| e[0].to_i}.max,
  }
end.select do |game|
  (game[:red] <= MAX_RED) && (game[:green] <= MAX_GREEN) && (game[:blue] <= MAX_BLUE)
end

result = games.reduce 0 do |accomulator, game|
  accomulator + game[:n]
end

puts result
